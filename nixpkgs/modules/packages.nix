{ pkgs, ... }:{
  	
    home.packages = with pkgs; [
        sysstat
        perl
        dconf # Required for some GTK based app's settings to be saved
          
        # General utils
        htop gotop
        wget git
        unar
        neofetch
        tree
        bat
        feh
        maim
        xclip
        clipmenu
        libnotify
        lxappearance
        mate.engrampa
		xfce.thunar
        unzip
        xwallpaper
        
        # Nix specific utils
        nix-index
        nix-prefetch-git
        direnv

        # Media
        ncspot
        mpv
        ffmpeg
        strawberry

        # Applications
        steam
        discord
        pavucontrol
        transmission-gtk
        teams
        typora
        aseprite-unfree
        calibre
        gimp
        inkscape

        #themes
        arc-theme 
        capitaine-cursors
        
        #terminal
        termite

		#wine
		winetricks
		lutris
		protontricks
    ]; 
}
