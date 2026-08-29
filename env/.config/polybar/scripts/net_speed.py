#!/usr/bin/env python3
"""Global network up/down speed from /proc/net/dev (sum of non-loopback ifaces)."""

import argparse
import time


def read_net():
    total = {"rx": 0, "tx": 0}
    with open("/proc/net/dev", "r") as fh:
        for line in fh:
            if ":" not in line:
                continue
            iface, data = line.split(":", 1)
            if iface.strip() == "lo":
                continue
            fields = data.split()
            total["rx"] += int(fields[0])
            total["tx"] += int(fields[8])
    return total


def fmt_speed(bps):
    value = float(bps)
    for unit in ("B/s", "KiB/s", "MiB/s", "GiB/s"):
        if value < 1024 or unit == "GiB/s":
            if value >= 100:
                return f"{value:.0f} {unit}"
            return f"{value:.1f} {unit}"
        value /= 1024


def main():
    ap = argparse.ArgumentParser(description="Global network speed")
    ap.add_argument("--one", choices=["up", "down"], default=None)
    ap.add_argument("--interval", type=float, default=1.0)
    args = ap.parse_args()

    prev = read_net()
    time.sleep(args.interval)
    cur = read_net()

    rx = (cur["rx"] - prev["rx"]) / args.interval
    tx = (cur["tx"] - prev["tx"]) / args.interval

    if args.one == "down":
        print(fmt_speed(rx))
    elif args.one == "up":
        print(fmt_speed(tx))
    else:
        print(f"\u2193 {fmt_speed(rx)}  \u2191 {fmt_speed(tx)}")


if __name__ == "__main__":
    main()