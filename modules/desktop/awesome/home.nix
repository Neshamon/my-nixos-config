# Awesome Home Manager config

{ config, lib, pkgs, protocol, inputs, ... }:
let
	location = "/home/neshamon/.setup";
in
{
	config = lib.mkIf ( protocol == "X" ) {
		xsession = {
			enable = true;
			numlock.enable = true;
			windowManager = {
				awesome = {
					enable = true;
					package = pkgs.awesome.overrideAttrs(o: {
						patches = [ ];
						src = pkgs.fetchFromGitHub {
							repo = "awesome";
							owner = "awesomeWM";
							rev = "b7bac1dc761f7e231355e76351500a97b27b6803";
							sha256 = "sha256-SxydaQScu0kvBn3VOnT29/Sji0Y+7my+tO46mpMggAQ=";
						};
					});
					
				};
			};
		};
		
		home.file = {
			".config/awesome".source = 
			config.lib.file.mkOutOfStoreSymlink "${location}/configs/awesome";
			"${location}/configs/awesome/modules/bling".source = inputs.bling.outPath;
			"${location}/configs/awesome/modules/rubato".source = inputs.rubato.outPath;
		};

	#	programs = {
	#		wezterm = {
	#			
	#			package = pkgs.wezterm;
	#		};
	#	};
	};
}
