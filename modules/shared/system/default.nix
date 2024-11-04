{pkgs, ...}: 
{
    config = {
        environment.systemPackages = with pkgs; [
            wget
            bash
            git
            fontconfig
            nil
            openssl
            virt-viewer
            proton-pass
            protonvpn-cli
            kitty
            zellij
            gnupg
            pinentry-curses
            lsof
            zsh
            lf
            ripgrep
            htop
            neofetch
            jq
            bat
            tmux
            postgresql # for cli tooling
        ];

        i18n.defaultLocale = "en_CA.UTF-8";

        main-user = {
            enable = true;
            userName = "arrayofone";
            description = "Primordial Devboi";
            auto-login = false;
        };

        hostFonts.enable = true;

        time.timeZone = "America/Vancouver";
    };
}