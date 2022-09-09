{ config, pkgs, lib, ... }:
let
	location = "$HOME/.setup";
in
{
	imports = 
	[
		#./picom.nix
	];

	home.file.".config/tint2".source = config.lib.file.mkOutOfStoreSymlink "${location}/.setup/configs/tint2";
}
