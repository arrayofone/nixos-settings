{lib, pkgs, config, ...}: 
{
    options.host.applications.firefox = {
        enable = lib.mkEnableOption "enable firefox";
    };

    config = lib.mkIf config.host.applications.firefox.enable {
        programs.firefox.enable = true;
    };
}