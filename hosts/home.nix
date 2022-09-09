# General Home Manager config

{ config, lib, pkgs, user, ... }:

{
	imports = 							# Home Manager Modules
		( import ../modules/editors ) ++
		( import ../modules/programs ) ++
		( import ../modules/services ) ++
		( import ../modules/shell );

	home = {
		username = "${user}";
		homeDirectory = "/home/${user}";

		packages = with pkgs; [
			#Terminal
			btop				# Resource Manager

			# Video/Audio
			feh					# Image Viewer
			pavucontrol			# Audio control

			# Apps
			librewolf			# Browser

			# File Management
			xarchiver			# Archive Manager
			xfce.thunar			# File Manager
			rsync				# Syncer
			unzip				# Zip files
			tree				# Directory listing
			diffoscope			# Diff Viewer
		];
		file.".config/wall".source = ../modules/themes/wall;
		pointerCursor = {				# Sets cursor system wide
			name = "phinger-cursors";
			package = pkgs.phinger-cursors;
			size = 32;
		};
		stateVersion = "22.05";
	};

	programs = {
		home-manager.enable = true;
	};

	gtk = { 							# Theming
		enable = true;
		theme = {
			name = "Lounge-night-compact";
			package = pkgs.lounge-gtk-theme;
		};
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
	#	font = {
	#		name = "Commissioner";
	#		size = 10;
	#	};
	};
}
