
# Nix setup using Home-Manager

{ config, pkgs, inputs, nixgl, user, ... }:

{
	home = {
		packages = [
			(import nixgl { inherit pkgs; }).nixGLIntel			# OpenGL for GUI apps. Add to aliases is recommended
			pkgs.hello
		];

		activation = {											# Run script during rebuild / switch
			linkDesktopApplications = {							# Script that will add all packages to the system menu
				after = [ "writeBoundary" "createXdgUserDirectories" ];
				before = [ ];
				data = ''
					rm -rf ${config.xdg.dataHome}/"applications/home-manager"
					mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
					cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager"
				'';
			};
		};	
	};

	programs = {
		home-manager.enable = true;								# Home-manager
	};

	nix = {														# Nix Package Manager Settings
		setings = {												# Optimize syslinks
			auto-optimise-store = true;
		};
		package = pkgs.nixFlakes;								# Enable nixFlakes on system
		registry.nixpkgs.flake = inputs.nixpkgs;
		extraOptions = ''
			experimental-features = nix-command flakes
			keep-outputs 		  = true
			keep-derivations	  = true
		'';
	};
	nixpkgs.config.allowUnfree = true;							# Allow proprietary software
}
