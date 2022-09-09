# Awesome config

{ config, lib, pkgs, protocol, ... }:

{
	config = lib.mkIf ( protocol == "X" ) {
		hardware.opengl.enable = true;
		
		services = {
			xserver = {
				enable = true;

				layout = "us";					# Keyboard layout
				# libinput.enable = true;		# Don't know if I need this

				displayManager = {
					startx = {
						enable = true;
					};
					defaultSession = "none+awesome";
				};

				videoDrivers = [
					"nouveau"
				];
				# environment.systemPackages = with pkgs; [];	Not sure if I need this
			};
		};

		programs = {
				zsh = {
					enable = true;			# Backup shell
				};
				dconf = {
					enable = true;
				};
			#	wezterm = {
			#		enable = true;
			#		package = wezterm.overrideAttrs(o: {
			#			src = pkgs.fetchFromGitHub {
			#				repo = "wezterm";
			#				owner = "wez";
			#				rev = "9559404c3c471951d3ada1116fbcfc32af616a2c";
			#				sha256 = "sha256-SKEab2rZ/wkCiHLvi2cocccw3K1J3q5+9N1a9pmR4QI=";
			#			};
			#		});						
			#	};
			};
		
		environment = {
			loginShellInit = ''
				if [["$(tty)" = "/dev/tty1"]]; then
					pgrep awesome || startx
				fi
			'';

			systemPackages = with pkgs; [
				stylua
				lite-xl
			];
		};
	};
}
