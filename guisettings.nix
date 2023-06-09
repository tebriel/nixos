{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontDir.enable = true;
  };

  console = {
    font = "JetBrainsMonoNerdFont-Regular";
  };
}
