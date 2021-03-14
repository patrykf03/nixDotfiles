{ pkgs, ... }: {

    programs = {
        rofi = {
	        enable = true;
	        cycle = true;
	        extraConfig = {
		        "modi" = "drun,run,window";
		        "bw" = 5;
		        "padding" = 5;
		        "font" = "FiraCode Nerd Font 14";
		        "click-to-exit" = false;
		        "fixed-num-lines" = true;
		        "sidebar-mode" = true;
		        };
	        scrollbar = false;
	        width = 30;
	        theme = "/home/patryk/.config/nixpkgs/modules/nord.rasi";
        };
    };
}
