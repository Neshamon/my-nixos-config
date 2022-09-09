
# These are the different profiles that can be used when building Nix

{ lib, inputs, nixpkgs, home-manager, nixgl, user, ... }:

{
	ruakh = home-manager.lib.homeManagerConfiguration { # Currently the only host that can be built
		system = "x86_64-linux";
		username = "${user}";
		homeDirectory = "home/${user}";
		configuration = import ./ruakh.nix;
		extraSpecialArgs = { inherit inputs nixgl user; };		
	};
}
