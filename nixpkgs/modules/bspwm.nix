{ pkgs, config, ... }: {

	xsession.windowManager.bspwm = {
		enable = true;
		monitors = { HDMI-0 = [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" ] ; };
		extraConfig = ''
			bspc config normal_border_color "#3b4252"
			bspc config focused_border_color "#8fbcbb"
			bspc config border_width 3
			bspc ignore_emwh_focus true
			bspc config window_gap 25
			bspc config borderless_monocle true
			bspc config single_monocle true
			bspc config gapless_monocle true
			setxkbmap gb pl
			xwallpaper --zoom /media/files/wallpapers/nice.png
			xrandr --output HDMI-0 --mode 1920x1080 --rate 74.97
			xmousepasteblock &
			clipit
		'';
	};
	services = {
		sxhkd = {
			enable = true;
			keybindings = {
				"super + d" = "rofi -show drun -show-icons";
				"super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}' --follow";
				"super + shift + {d,a}" = "bspc node @/ -C {forward,backward}";
				"super + Return" = "termite";
				"super + shift + r" = "pkill -usr1 -x sxhkd; notify-send 'sxhkd' 'Reloaded config'";
				"super + shift + q" = "bspc node -c";
				"Print" = "maim -s --highlight -c 0.1796,0.2031,0.25,0.65  | xclip -selection clipboard -t image/png
				";
				"super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
				"super + space" = ''
				if [ -z "$(bspc query -N -n focused.floating)" ]; then \                    
				        bspc node focused -t floating; \                                        
				    else \                                                                      
				        bspc node focused -t tiled; \                                           
				    fi
				'';			
				"super + t" = ''
				if [ -z "$(bspc query -N -n focused.pseudo_tiled)" ]; then \                    
				        bspc node focused -t pseudo_tiled; \                                        
				    else \                                                                      
				        bspc node focused -t tiled; \                                           
				    fi
				'';
				"super + f" = ''
				if [ -z "$(bspc query -N -n focused.fullscreen)" ]; then \                    
				        bspc node focused -t fullscreen; \                                        
				    else \                                                                      
				        bspc node focused -t tiled; \                                           
				    fi
				'';
			};
		};

		picom = {
			enable = true;
			vSync = true;
			backend = "xr_glx_hybrid";
			extraOptions = ''
				xrender-sync-fence = true;
			'';
			};	
	};

}
