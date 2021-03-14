{ pkgs, config, ... }: {

	services.polybar = {
		enable=true;
		package=pkgs.polybarFull;
		script = "~/.config/nixpkgs/modules/launch-polybar.sh";			
	};
}
