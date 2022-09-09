# Home Manager desktop configuration

{ pkgs, sources, lite-xl-git, ... }:

{
	imports =
	[
		# Window manager(s) will go here
		../../modules/desktop/awesome/home.nix
	];

	home = {								# Specific packages for desktop
		packages = with pkgs; [
			# Applications
			inkscape		# Vector Graphical Editor
			obs-studio		# Video Recording and live streaming
			onlyoffice-bin	# Office Packages
			zathura			# PDF viewer
			lite-xl-git
		];
	};
}
