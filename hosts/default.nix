# Default configs are the configs that are loaded when nix is only given a directory instead of a file
# Default configs organize the rest of the configs

{ 
	lib, self, inputs, nixpkgs, home-manager, 
	nur, user, location, protocol, bling, rubato, 
	sources, wezterm-git, lite-xl-git, stevenblack-git, awesome-git, ... 
}:

let
	system = "x86_64-linux";										# System architecture

	pkgs = import nixpkgs {
		inherit system;
		config.allowUnfree = true;									# Allow proprietary software
	};

	lib = nixpkgs.lib;
in
{
	desktop = lib.nixosSystem {										# Desktop profile
		inherit system;
		specialArgs = { 
			inherit inputs user location 
			sources lite-xl-git awesome-git stevenblack-git 
			wezterm-git bling rubato protocol
			system;
		 };  # Pass flake variable
		modules = [													# Used modules
			nur.nixosModules.nur
			./desktop
			./configuration.nix

			home-manager.nixosModules.home-manager {				# Home manager that's used.
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.extraSpecialArgs = { inherit inputs user protocol; bling = inputs.bling; rubato = inputs.rubato; };  # Pass flake variable
				home-manager.users.${user} = {
					imports = [( import ./home.nix )] ++ [( import ./desktop/home.nix )];
				};
			}
		];
	};

	laptop = lib.nixosSystem {										# Laptop profile
		inherit system;
		specialArgs = { inherit inputs user location; };
		modules = [
			# awesome.nixosModules.default
			./laptop
			./configuration.nix

			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.extraSpecialArgs = { inherit user; };
				home-manager.users.${user} = {
					imports = [( import ./home.nix )] ++ [( import ./laptop/home.nix )];
				};
			}
		];
	};
}
