{ lib, config, ... }: 
let
    forAllUsers = lib.genAttrs [
        config.main-user.userName # always create home for the main user
        # add any other custom users here
    ];
in
{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users = forAllUsers (user: 
            lib.mkMerge [
                ({
                    programs = {
                        home-manager = {
                            enable = true;
                        };
                    };
                    home = {
                        stateVersion = "23.11";
                        file = {};
                        username = "${user}";
                        homeDirectory = "/home/${user}";
                    };
                })
                (import ./${user}.nix)
            ]
        );
    };
}