{config, lib, ...}: {
    imports = [
        ./dunst
        ./hyprland
        ./hyprlock
        ./waybar
        
        ./nvidia
    ];

    options.host.desktop = {
        gui.enable = lib.mkEnableOption "enable gui desktop";
        nvidia.enable = lib.mkEnableOption "enable nvidia";
    };

    config = {
        # desktop gui stuff
        dunst.enable = lib.mkIf config.host.desktop.gui.enable true;
        hyprland.enable = lib.mkIf config.host.desktop.gui.enable true;
        hyprlock.enable = lib.mkIf config.host.desktop.gui.enable true;
        waybar.enable = lib.mkIf config.host.desktop.gui.enable true;

        # nvidia driver config for wayland
        nvidia.enable = lib.mkIf config.host.desktop.nvidia.enable true;
    };
}