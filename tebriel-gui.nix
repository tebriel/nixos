{ config, pkgs, ... }:
{
  users.users.tebriel.packages = with pkgs; [
    _1password-gui
    discord
    firefox
    microsoft-edge-beta
    plex-media-player
    plexamp
    thunderbird
    todoist
    vlc
  ];

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["tebriel"];
  };
}
