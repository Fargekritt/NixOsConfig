{
  config,
  pkgs,
  programs,
  lib,
  services,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "amund";
  home.homeDirectory = "/home/amund";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
services.gnome-keyring.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  nodejs
    gcc
    gcr
    git
    pcsx2
    jetbrains-toolbox
    spotify
    oh-my-zsh
    thunderbird
    docker
    gnumake
    rofi
    slurp
    grim
    wl-clipboard
    stylua
    prusa-slicer
    unzip
            winetricks
        wine-staging
	libpng
            (lutris.override (finalAttrs: {
          extraPkgs = pkgs: [
            pkgs.wineWowPackages.stagingFull
            pkgs.winetricks
            pkgs.libappindicator-gtk2
            pkgs.libappindicator-gtk3
            pkgs.gnomeExtensions.appindicator
            pkgs.libayatana-appindicator
            pkgs.appindicator-sharp
            pkgs.haskellPackages.gi-ayatana-appindicator3
            pkgs.mangohud
          ];
        }))
	        (pkgs.makeDesktopItem {
          name = "microsoft-edge-wl";
          exec =
            "${pkgs.microsoft-edge}/bin/microsoft-edge --enable-features=UseOzonePlatform --ozone-platform=wayland --use-gl=desktop";
          desktopName = "microsoft-edge-wayland";
        })
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    "/home/amund/.config/waybar".source = ./dotfiles/waybar;
    "/home/amund/.config/hypr".source = ./dotfiles/hypr;
#    "/home/amund/.config/nvim".source = ./dotfiles/new-nvim;
    "/home/amund/.config/rofi".source = ./dotfiles/rofi;
    "${config.home.homeDirectory}/.ideavimrc".source = ./dotfiles/ideavim/.ideavimrc;
  };


  # home.file creates symlink to readonly store. breaks Lazy (lazy-lock.json)
home.activation.symlinkDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  ln -sf $HOME/nixos/hosts/nixos/dotfiles/nvim/nvim $HOME/.config/nvim
'';

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/amund/etc/profile.d/hm-session-vars.sh
  #
  programs.git = {
    enable = true;
    extraConfig = {
      user.name = "Amund";
      user.email = "Lullinj98@gmail.com";
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      update = "sudo nixos-rebuild switch --flake /home/amund/nixos#nixos";
      upgrade = "sudo nixos-rebuild switch --upgrade --flake /home/amund/nixos#nixos";

    };
    oh-my-zsh = {
      enable = true;
      plugins = [];
      theme = "robbyrussell";
    };
  };
  programs.plasma = {
    enable = true;
    kscreenlocker.autoLock = false;
    powerdevil.AC.autoSuspend.action = "nothing";
    kwin.effects.shakeCursor.enable = false;
  };
  programs.chromium.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.waybar = {
    enable = true;
  };
}
