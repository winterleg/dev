{ config, pkgs, lib, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;


    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Toronto";

    # Select internationalisation properties.
    i18n.defaultLocale = "fr_CA.UTF-8";

    services.upower.enable = true;
    services.xserver.enable = true;

    services.displayManager.sddm.enable = true;
    services.displayManager.gdm.enable = false;
    services.desktopManager.gnome.enable = true;

    hardware.ckb-next.enable = true;
    # Configure keymap in X11
    services.xserver.xkb.extraLayouts.usc = {
        description = "US (TRUE colemak)";
        symbolsFile = ./xkbconfig/us;
        languages = [ "eng" ];
    };
    services.xserver.xkb.extraLayouts.cac = {
        description = "CA (TRUE colemak)";
        symbolsFile = ./xkbconfig/ca;
        languages = [ "fr_CA" ];
    };
    services.xserver.xkb = {
        layout = "usc";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.defaultUserShell = pkgs.zsh;
    users.users.fuyu147 = {
        isNormalUser = true;
        description = "fuyu147";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            nodejs_22
            eza
            bash-language-server
            udiskie

            waybar
            rofi

            swww
            typst

            thunderbird

            ripgrep
            brightnessctl
            dunst

            vesktop
            vscode

            bat
            zathura

            zsh-fzf-tab

            kitty
            ranger
            yazi

            hyprlock
            github-cli
        ];
    };

    programs.hyprland.enable = true;
    programs.firefox.enable = true;
    programs.zsh.enable = true;
    programs.zsh.ohMyZsh.enable = true;

    services.gnome.gnome-keyring.enable = true;
    services.keyd = {
      enable = true;
    };

    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
            # fcitx5-chinese-addons
        ];
    };

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        courier-prime
        iosevka
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #  wget
        fzf
        neovim
        ghostty
        lshw
        git
        tmux
        clang
        gcc
        rustc
        cargo
        libdbusmenu
        jq
        power-profiles-daemon
    ];

nixpkgs.config.packageOverrides = pkgs: {
  ckb-next = pkgs.ckb-next.overrideAttrs (old: {
    cmakeFlags = (old.cmakeFlags or []) ++ [ "-DUSE_DBUS_MENU=0" ];
  });
};

    # opengl
    hardware.graphics = {
        enable = true;
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
        # of just the bare essentials.
        powerManagement.enable = false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
            version = "580.95.05";
            sha256_64bit = "19w227zb4qfrwpj6g53nk8d4zm832cfg3sfdn839haw4ivpz17l4";
            openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
            settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
            persistencedSha256 = lib.fakeSha256;
        };
      };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

}
