{ config, lib, pkgs, ... }:

let
    cfg = config.hostFonts;
in
{
    options.hostFonts = {
        enable = lib.mkEnableOption "enable hostFonts";
    };

    config = lib.mkIf cfg.enable {
        fonts = {
            packages = with pkgs; [
                intel-one-mono
                ubuntu_font_family
                liberation_ttf
            ];
            
            fontconfig = {
                defaultFonts = {
                    sansSerif = [ "Ubuntu" ];
                    monospace = [ "Intel One Mono" ];
                };
            };
        };
    };
}