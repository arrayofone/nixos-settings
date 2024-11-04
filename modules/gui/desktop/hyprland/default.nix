{
    config,
    lib,
    inputs,
    pkgs,
    ...
}: {
    options.hyprland = {
        enable = lib.mkEnableOption "hyprland";
    };

    config = lib.mkIf config.hyprland.enable {
        nix.settings = {
            substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        };

        programs = {
            hyprland = {
                # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
                portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            };
        };

        services = {
            hypridle = {
                enable = true;
            };

            displayManager = {
                sddm = {
                    enable = true;
                    package = pkgs.kdePackages.sddm;
                    wayland = {
                        enable = true;
                    };
                    settings = {
                        Wayland = {
                            SessionDir = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
                        };
                    };
                    catppuccin = {
                        enable = true;
                        assertQt6Sddm = true;
                        flavor = "macchiato";
                        font = "Intel One Mono";
                        fontSize = "12";
                        loginBackground = true;
                    };
                };
            };
        };

        home-manager.users.${config.main-user.userName} = {
            wayland.windowManager.hyprland = {
                enable = true;
                plugins = [];
                xwayland = {
                    enable = true;
                };

                package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            
                settings = {
                    "$terminal" = "kitty";
                    "$fileManager" = "dolphin";
                    "$menu" = "rofi -show drun -show-icons";
                    "$mainMod" = "SUPER";

                    monitor = [
                        ",preferred,auto,1"
                    ];

                    env = [
                        "XCURSOR_SIZE,24"
                        "HYPRCURSOR_SIZE,24"
                        "ELECTRON_OZONE_PLATFORM_HINT,x11"
                    ];

                    general = {
                        gaps_in = 2;
                        gaps_out = 10;

                        border_size = 1;

                        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                        "col.inactive_border" = "rgba(595959aa)";

                        resize_on_border = false;

                        allow_tearing = false;

                        layout = "dwindle";
                    };

                    decoration = {
                        rounding = 6;

                        active_opacity = 1.0;
                        inactive_opacity = 1.0;

                        drop_shadow = true;
                        shadow_range = 4;
                        shadow_render_power = 3;
                        "col.shadow" = "rgba(1a1a1aee)";

                        blur = {
                            enabled = true;
                            size = 3;
                            passes = 1;
                            vibrancy = 0.1696;
                        };
                    };

                    cursor = {
                        no_hardware_cursors = true;
                    };

                    animations = {
                        enabled = true;

                        bezier = [
                            "easeOutQuint,0.23,1,0.32,1"
                            "easeInOutCubic,0.65,0.05,0.36,1"
                            "linear,0,0,1,1"
                            "almostLinear,0.5,0.5,0.75,1.0"
                            "quick,0.15,0,0.1,1"
                        ];

                        animation = [
                            "global, 1, 10, default"
                            "border, 1, 5.39, easeOutQuint"
                            "windows, 1, 4.79, easeOutQuint"
                            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                            "windowsOut, 1, 1.49, linear, popin 87%"
                            "fadeIn, 1, 1.73, almostLinear"
                            "fadeOut, 1, 1.46, almostLinear"
                            "fade, 1, 3.03, quick"
                            "layers, 1, 3.81, easeOutQuint"
                            "layersIn, 1, 4, easeOutQuint, fade"
                            "layersOut, 1, 1.5, linear, fade"
                            "fadeLayersIn, 1, 1.79, almostLinear"
                            "fadeLayersOut, 1, 1.39, almostLinear"
                            "workspaces, 1, 1.94, almostLinear, fade"
                            "workspacesIn, 1, 1.21, almostLinear, fade"
                            "workspacesOut, 1, 1.94, almostLinear, fade"
                        ];
                    };

                    dwindle = {
                        pseudotile = true;
                        preserve_split = true;
                    };

                    master = {
                        new_status = "master";
                    };

                    misc = {
                        force_default_wallpaper = -1;
                        disable_hyprland_logo = false;
                    };

                    input = {
                        kb_layout = "us";
                        kb_variant = "";
                        kb_model = "";
                        kb_options = "";
                        kb_rules = "";

                        follow_mouse = 1;
                        sensitivity = 0;

                        touchpad = {
                            natural_scroll = false;
                        };
                    };

                    gestures = {
                        workspace_swipe = false;
                    };

                    device = {
                        name = "epic-mouse-v1";
                        sensitivity = -0.5;
                    };

                    opengl = {
                        nvidia_anti_flicker = false;
                        force_introspection = 2;
                    };

                    bind = [
                        "$mainMod, Q, exec, $terminal"
                        "$mainMod, C, killactive,"
                        "$mainMod, M, exit,"
                        "$mainMod, E, exec, $fileManager"
                        "$mainMod, V, togglefloating,"
                        "$mainMod, R, exec, $menu"
                        "$mainMod, P, pseudo,"
                        "$mainMod, J, togglesplit,"
                        "$mainMod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"

                        "$mainMod, left, movefocus, l"
                        "$mainMod, right, movefocus, r"
                        "$mainMod, up, movefocus, u"
                        "$mainMod, down, movefocus, d"

                        "$mainMod, 1, workspace, 1"
                        "$mainMod, 2, workspace, 2"
                        "$mainMod, 3, workspace, 3"
                        "$mainMod, 4, workspace, 4"
                        "$mainMod, 5, workspace, 5"
                        "$mainMod, 6, workspace, 6"
                        "$mainMod, 7, workspace, 7"
                        "$mainMod, 8, workspace, 8"
                        "$mainMod, 9, workspace, 9"
                        "$mainMod, 0, workspace, 10"

                        "$mainMod SHIFT, 1, movetoworkspace, 1"
                        "$mainMod SHIFT, 2, movetoworkspace, 2"
                        "$mainMod SHIFT, 3, movetoworkspace, 3"
                        "$mainMod SHIFT, 4, movetoworkspace, 4"
                        "$mainMod SHIFT, 5, movetoworkspace, 5"
                        "$mainMod SHIFT, 6, movetoworkspace, 6"
                        "$mainMod SHIFT, 7, movetoworkspace, 7"
                        "$mainMod SHIFT, 8, movetoworkspace, 8"
                        "$mainMod SHIFT, 9, movetoworkspace, 9"
                        "$mainMod SHIFT, 0, movetoworkspace, 10"

                        "$mainMod, S, togglespecialworkspace, magic"
                        "$mainMod SHIFT, S, movetoworkspace, special:magic"

                        "$mainMod, mouse_down, workspace, e+1"
                        "$mainMod, mouse_up, workspace, e-1"
                    ];

                    bindm = [
                        "$mainMod, mouse:272, movewindow"
                        "$mainMod, mouse:273, resizewindow"
                    ];

                    bindel = [
                        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
                    ];

                    bindl = [
                        ", XF86AudioNext, exec, playerctl next"
                        ", XF86AudioPause, exec, playerctl play-pause"
                        ", XF86AudioPlay, exec, playerctl play-pause"
                        ", XF86AudioPrev, exec, playerctl previous"
                    ];

                    windowrulev2 = [
                        "suppressevent maximize, class:.*"
                        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
                    ];

                    exec-once = [
                        "nm-applet --indicator"
                    ];

                    misc = {
                        vfr = 0;
                    };

                    debug = {
                        damage_tracking = 0;
                    };

                    render = {
                        explicit_sync = 2;
                        explicit_sync_kms = 0;
                    };
                };
                # systemd = {
                #     enable = true;
                # };
            };

            home = {
                packages = with pkgs; [
                    rofi-wayland
                    networkmanagerapplet
                ];
            };
        };
    };
}
