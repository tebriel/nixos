{ config, pkgs, ... }:
{
  users.users.tebriel.packages = with pkgs; [
    _1password-gui
    alacritty
    gnomeExtensions.toggle-alacritty
    discord
    firefox
    microsoft-edge-beta
    plex-media-player
    plexamp
    remmina
    spotify
    thunderbird
    todoist
    todoist-electron
    vlc
    xournalpp
  ];

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["tebriel"];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-21.4.0"
  ];
}
