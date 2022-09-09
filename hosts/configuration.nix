# Main system config
# TODO Should think about making a stable config

{ config, lib, pkgs, inputs, user, location, ... }:

{
	imports =								# Import window or display manager 
		[
			# ../modules/editors/lite-xl		# ! Comment this out on first install !
		];

	users.users.${user} = {					# System User
		isNormalUser = true;
		extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
		shell = pkgs.nushell;				# Default shell
	};

	time.timeZone = "America/Chicago";		# Time Zone and Internationalization
	i18n.defaultLocale = "en_US.UTF-8";

	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";						# or us/azerty/etc
	};

	security.rtkit.enable = true;			# Secure realtime user process scheduling
	sound = {
		enable = true;
		mediaKeys = {
			enable = true;
		};
	};

	fonts.fonts = with pkgs; [				# Fonts
		carlito								# NixOs
		vegur								# NixOs
		source-code-pro
		jetbrains-mono
		font-awesome						# Icons
		ibm-plex
		noto-fonts-emoji-blob-bin
		cascadia-code
		(nerdfonts.override {
			fonts = [
				"FiraCode"
				"CascadiaCode"
				"Iosevka"
				"JetBrainsMono"
			];
		})
	];

	fonts.fontconfig = {
		defaultFonts = {
			monospace = [ "Cascadia Code" ];
		    sansSerif = [ "Cascadia Code" ];
			serif = [ "Cascadia Code" ];
			emoji = [ "Blobmoji" ];
		};
	};

	environment = {
		variables = {
			TERMINAL = "wezterm";
			EDITOR = "micro";
			VISUAL = "lite-xl";
		};
		systemPackages = with pkgs; [		# Default packages installed system wide
			neovim							# Will think about it 
			git							# Will think about it
			killall
			usbutils
			wget
			nushell
			xorg.xrandr
			symlinks
			nvfetcher
		];
	};

	services = {
		pipewire = {							# Sound
			enable = true;
			pulse.enable = true;
		};
		openssh = {							# SSH: Secure shell
			enable = true;
			allowSFTP = true;				# SFTP: Secure File Transfer Protocol
											# connect: $ sftp <user>@<ip/domain>
											# commands:
											#	- lpwd & pwd = print (local) parent working dir
											#	- put/get <filename> = send or receive file
			extraConfig = ''
				HostKeyAlgorithms +ssh-ed25519
			'';								# Temporary extra config so ssh will work in guacamole
		};
	};

	nix = {									# Nix Package Manager settings
		settings = {
			auto-optimise-store = true;		# Optimize syslinks
		};
		gc = {								# Automatic garbage collection
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 7d";
		};
		package = pkgs.nixFlakes;			# Enable nixFlakes on system
		registry.nixpkgs.flake = inputs.nixpkgs;
		extraOptions = ''
			experimental-features = nix-command flakes
			keep-outputs		  = true
			keep-derivations 	  = true
		'';
	};										# Keep-outputs will keep the output paths of runtime dependencies which ensures fast rebuild times.
	nixpkgs.config.allowUnfree = true;		# Allow proprietary software

	system = {								# NixOs Settings
		autoUpgrade = {						# Allow auto update
			enable = true;
			channel = "https://nixos.org/channels/nixos-unstable";	# Unstable
		};
		copySystemConfiguration = true;
		stateVersion = "22.05";
	};

	programs.dconf.enable = true;
}
