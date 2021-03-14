{ config, pkgs, ... }:
let
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
in{
    imports = [
        ./modules/packages.nix
        ./modules/zsh.nix
        ./modules/nvim.nix
        ./modules/dunst.nix
        ./modules/rofi.nix
        ./modules/bspwm.nix
        ./modules/polybar.nix
        ./modules/autoadd.nix
    ];
	
    nixpkgs.config = {
    	allowUnfree = true;
	};

	
    home = {
        username = "patryk";
        homeDirectory = builtins.getEnv "HOME";
        stateVersion = "21.03";
        sessionVariables.TERMINAL = [ "termite" ];

    };

    programs = {
        home-manager.enable = true;
        command-not-found.enable = true;
    };

    services.lorri.enable = true;
    
    xsession = {
      enable = true;
      scriptPath = ".hm-xsession";
    };

	gtk = {
	    enable = true;
	    theme = let
	      plata-nord = (pkgs.plata-theme.overrideAttrs (attrs: {
	       	        version = "0.9.9"; # enter yourself from the nix-prefetch-git
	       	        src = pkgs.fetchFromGitHub {
	       	          owner = "patrykf03";
	       	          repo = "plata-theme";
	       	          rev = "4147e4827432737e17be67c9ecf197940bb649c7"; # get from prefetch
	       	          sha256 = "1mkn6d3lzbf8qfm5sp4wpp6z9iki9fil8ydhr6a0s3nzg4vi2wz5"; # get from prefetch
	       	        };
	       }));
	      in {
	      package = (plata-nord.override { accentColor = "#8fbcbb"; selectionColor = "#8fbcbb"; suggestionColor = "#88c0d0"; destructionColor = "#bf616a";});
	      name = "Plata-Noir";
		};
	    font.name = "Fira Sans 11";
	    gtk3.extraConfig = { gtk-cursor-theme-name= "capitaine-cursors-white"; };
		iconTheme.name = "Papirus-Dark";
	};


  
    xresources.properties = {
        "*.foreground" = "#D8DEE9";
	    "*.background" = "#2E3440";
	    "*.cursorColor" = "#D8DEE9";
	    "*.fading" = 0;
	    "*.fadeColor" = "#4C566A";

	    "*.color0" = "#2E3440";
	    "*.color1" = "#BF616A";
	    "*.color2" = "#A3BE8C";
	    "*.color3" = "#EBCB8B";
	    "*.color4" = "#8FBCBB";
	    "*.color5" = "#B48EAD";
	    "*.color6" = "#81A1C1";
	    "*.color7" = "#E5E9F0";

	    "*.color8" = "#4C566A";
	    "*.color9" = "#BF616A";
	    "*.color10" = "#A3BE8C";
	    "*.color11" = "#EBCB8B";
	    "*.color12" = "#88C0D0";
	    "*.color13" = "#B48EAD";
	    "*.color14" = "#5E81AC";
	    "*.color15" = "#ECEFF4";

	    "xft.dpi" = "92";
	    
	    "*.alpha" = "1";
    };
}
