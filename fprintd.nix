{ config, pkgs, ... }:
{
  # Fingerprint configuration
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
}
