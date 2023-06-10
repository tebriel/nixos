# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tebriel = {
    isNormalUser = true;
    description = "Chris Moultrie";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # apps
      _1password-gui
      discord
      firefox
      microsoft-edge-beta
      thunderbird
      todoist
      plexamp
      plex-media-player

      # cli
      gh
      shellcheck
    ];
    shell = pkgs.zsh;
  };

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["tebriel"];
  };
}
