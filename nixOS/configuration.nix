# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = { 
	consoleFont   = "Lat2-Terminus16"; 
	consoleKeyMap = "uk"; 
	defaultLocale = "en_GB.UTF-8";
  }; 

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  
  # Enable flatpack
  services.flatpak.enable = true;

  # zsh
  programs.zsh = {
	enable = true;
	enableCompletion = true;
        enableAutosuggestions = true;
	interactiveShellInit = ''
		export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
		# Customize your oh-my-zsh options here
		ZSH_THEME="agnoster"
		plugins=(git)
		source $ZSH/oh-my-zsh.sh '';
	promptInit = "";
  };
   
  #Allow Unfree Softwtware
  nixpkgs.config.allowUnfree = true; 


  # Enable Oh-my-zsh
  programs.zsh.ohMyZsh = {
  	enable = true;
     	plugins = [ "git" "sudo" "docker" "kubectl" ];
       	};

  # Enable Docker
  virtualisation.docker.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
	defaultUserShell = pkgs.zsh;
	users.cstml = {
 		isNormalUser = true;
		description = "cstml";
		home = "/home/cstml";
    		extraGroups = [ "wheel" "networkmanager" "docker"]; # Enable ‘sudo’ for the user.
    		shell=pkgs.zsh; # Enable zsh as default shell
  	}; 
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget 
    firefox
    git
    tmux
    docker
    fzf

    emacs26
    emacs26Packages.helm
    emacs26Packages.paredit

    ghc
    emacs26Packages.haskell-mode

    entr
    erlang
    rebar3

    python3
    jupyter
    emacs26Packages.python-mode

    discord
    vim_configurable
    vifm
    zotero
    gnupg
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "20.09"; # Did you read the comment?

}

