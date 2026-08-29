#!/usr/bin/env python3
"""qBittorrent transfer up/down speed via the WebUI API.

Uses curl instead of Python's urllib: qBittorrent 5.1.4 built against
Qt 6.11 segfaults in Http::Connection::acceptsGzipEncoding when parsing
the headers urllib sends (e.g. 'Accept-Encoding: identity'), whereas curl
requests work (qBittorrent issues #23524, #24038, #24855).

Reads ~/.qb-admin for credentials:
  line 1: host:port (e.g. 127.0.0.1:32741)
  line 2: admin name
  line 3: admin password
"""

import argparse
import json
import os
import subprocess
import sys
import tempfile
import urllib.parse


def load_credentials():
    path = os.path.expanduser("~/.qb-admin")
    try:
        with open(path, "r") as fh:
            lines = [ln.strip() for ln in fh if ln.strip()]
    except OSError as exc:
        sys.exit(f"error: cannot read {path}: {exc}")
    if len(lines) < 3:
        sys.exit(f"error: {path} must have 3 lines: host:port / user / pass")
    base = lines[0]
    if "://" not in base:
        base = "http://" + base
    return base.rstrip("/"), lines[1], lines[2]


def request(base, path, post=None, cookie_jar=None, timeout=5):
    cmd = ["curl", "-sS", "-m", str(timeout), "-w", "\n%{http_code}"]
    if cookie_jar:
        cmd += ["-c", cookie_jar, "-b", cookie_jar]
    if post is not None:
        cmd += ["--data", post]
    cmd.append(base + path)
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        sys.exit(f"error: curl: {proc.stderr.strip()} {proc.stdout.strip()}")
    body, _, code = proc.stdout.rpartition("\n")
    return body, code.strip()


def fmt_speed(bps):
    value = float(bps)
    for unit in ("B/s", "KiB/s", "MiB/s", "GiB/s"):
        if value < 1024 or unit == "GiB/s":
            if value >= 100:
                return f"{value:.0f} {unit}"
            return f"{value:.1f} {unit}"
        value /= 1024


def main():
    ap = argparse.ArgumentParser(description="qBittorrent transfer speed")
    ap.add_argument("--one", choices=["up", "down"], default=None)
    args = ap.parse_args()

    base, user, password = load_credentials()
    jar = os.path.join(tempfile.gettempdir(), "qbt_upload.cookies")

    # LocalHostAuth is often disabled, so try anonymous first. If that is
    # rejected (403) fall back to a session login.
    body, code = request(base, "/api/v2/transfer/info")
    if code in ("401", "403"):
        _, code = request(
            base, "/api/v2/auth/login",
            post=urllib.parse.urlencode({"username": user, "password": password}),
            cookie_jar=jar)
        if code != "200":
            sys.exit(f"error: qBittorrent login failed (HTTP {code})")
        body, code = request(base, "/api/v2/transfer/info", cookie_jar=jar)

    if code != "200":
        sys.exit(f"error: HTTP {code} from {base}")
    try:
        info = json.loads(body)
    except ValueError:
        sys.exit(f"error: invalid JSON from {base} (HTTP {code})")

    rx = info.get("dl_info_speed", 0)
    tx = info.get("up_info_speed", 0)

    if args.one == "down":
        print(fmt_speed(rx))
    elif args.one == "up":
        print(fmt_speed(tx))
    else:
        print(f"\u2193 {fmt_speed(rx)}  \u2191 {fmt_speed(tx)}")


if __name__ == "__main__":
    main()