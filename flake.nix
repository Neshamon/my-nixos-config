{
	description = "My personal NixOs system flake configuration";

	inputs =												 # All flake references used to build NixOs setup. These are dependencies.
	{
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages
		
		home-manager = {									 # User Package Management
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nur = {
			url = "github:nix-community/NUR"; 				 # Nix User Repo packages
		};

		nixgl = {
			url = "github:guibou/nixGL";					 # OpenGL
			inputs.nixpkgs.follows = "nixpkgs";
		};

	#	awesome = {										 # May or may not need this
	#		url = "github:awesomeWM/awesome";
	#		inputs.nixpkgs.follows = "nixpkgs";
	#	};

		# AwesomeWM Modules

		bling = {
			url = "github:BlingCorp/bling";
			flake = false;
		};

		rubato = {
			url = "github:andOrlando/rubato";
			flake = false;
		};
	};

	outputs = inputs @ { self, nixpkgs, home-manager, nur, nixgl, bling, rubato, ... }:   # Function that tells my flake what to use and what to do with what dependencies.
		let															# Variables that can be used in the config files.
			user = "neshamon";
			location = "home/neshamon/.setup";
			protocol = "X";			# Desktop choice is "X" and "Wayland(?)" | Laptop ONLY "Wayland"
			sources = import ./npins;
			lite-xl-git = import sources.lite-xl {}; 
			wezterm-git = import sources.wezterm {}; 
			awesome-git = import sources.awesome {}; 
			stevenblack-git = import sources.hosts {}; 
		in 															# Use ^^^ variables in ...
		{
			nixosConfigurations = (
				import ./hosts {
					inherit (nixpkgs) lib;
					inherit inputs self nixpkgs home-manager nur user location lite-xl-git wezterm-git awesome-git stevenblack-git sources bling rubato protocol;
				}
			);

			homeConfigurations = (
				import ./nix {
					inherit (nixpkgs) lib;
					inherit inputs nixpkgs home-manager nixgl user;
				}
			);
		}; 
}
