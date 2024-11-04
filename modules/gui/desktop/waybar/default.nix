{ lib, config, pkgs, ... }: {
  options.waybar = {
    enable = lib.mkEnableOption "waybar";
  };

  config = lib.mkIf config.waybar.enable {
    home-manager.users.${config.main-user.userName} = {
      programs.waybar.enable = true;
      programs.waybar.systemd.enable = true;
      
      home = {
        packages = with pkgs; [
            waybar
            font-awesome # default icons for waybar
        ];
      };
    };
  };
}