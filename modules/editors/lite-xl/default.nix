{ config, pkgs, lib, location,  ... }:
with lib;
let cfg = config.modules.editors.lite-xl;
in
{
	options.modules.editors.lite-xl = {
		enable = mkEnableOption "lite-xl";
	};

	config = mkIf cfg.enable {
		home = {
			file.".config/lite-xl".source = config.lib.file.mkOutOfStoreSymlink "${location}/configs/lite-xl";  # Links the lite-xl config dir to the .config lite-xl dir
		};
	};
}
