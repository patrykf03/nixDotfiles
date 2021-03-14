# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:
let
wifi = (pkgs.linuxPackages_zen.rtl8192eu.overrideAttrs (attrs: {
        version = "unstable-2021-01-11"; # enter yourself from the nix-prefetch-git
        src = pkgs.fetchFromGitHub {
          owner = "Mange";
          repo = "rtl8192eu-linux-driver";
          rev = "faf68bbf82623335e7997a473f9222751e275927"; # get from prefetch
          sha256 = "1rz1j1yy66nwbxqsd7v9albhfjal210g8xis4vqmjk96zk0fz86r"; # get from prefetch
        };
      }));

in 
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  
 boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    blacklistedKernelModules = [ "rtl8xxxu" ];
    extraModulePackages = with config.boot.kernelPackages; [ wifi ];
    kernelParams = [ "quiet" ];
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the Plasma 5 Desktop Environment.
services.xserver = {
  	enable = true;
  	videoDrivers = [ "nvidia" ];
 	layout = "gb";
  	xkbVariant = "pl";
	xkbOptions = "eurosign:e";
	screenSection = ''
    	Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
       '';
 	displayManager = {
	  lightdm.enable = true;
	  autoLogin.enable = true;
	  autoLogin.user = "patryk";
	  #session
 };
  	
};

 services.xserver.desktopManager.session = [ {
         name = "home-manager";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
		} ];

  security.rtkit.enable = true;
  security.sudo.enable = true;
  #32bit opengl
  hardware.opengl.driSupport32Bit = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  #bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

    nix = {
    allowedUsers = [ "@wheel" ]; # Allow users in the "wheel" group to control the nix deamon
    autoOptimiseStore = true;
    trustedUsers = [ "root" "patryk" ];

  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.patryk = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" "networkmanager" "scanner" "lp" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.zsh;
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget 
    vim
    firefox
    neofetch
    papirus-icon-theme
    libreoffice
    nano
    pulseaudio-ctl
    micro
    wineWowPackages.staging
    virt-manager
  ];

virtualisation.libvirtd.enable = true;
programs.dconf.enable = true;

fonts = {
  enableDefaultFonts = true;
  fonts = with pkgs; [ 

     nerdfonts
     fira
     
     twitter-color-emoji
     _3270font
     dina-font-pcf
     dina-font
     iosevka
     jetbrains-mono
     monoid
     cascadia-code
     
  ];

  fontconfig = {
    defaultFonts = {
      monospace = [ "FiraCode nerd font condensed" ];
      emoji = [ "twitter color emoji" ];
    };
  };
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  systemd.services.NetworkManager-wait-online.enable = false;
  programs.zsh.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.03"; # Did you read the comment?  
}

