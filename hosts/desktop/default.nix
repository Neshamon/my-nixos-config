# Specific system config settings for desktop

{ pkgs, lib, user, lite-xl-git, awesome-git, wezterm-git, stevenblack-git,  ... }:
let
#	overlay = _: pkgs: {
#		lite-xl-test = (import sources.lite-xl {}).lite-xl;
#	};
#	nixpkgs = import sources.nixpkgs { overlays = [ overlay ]; config = {}; };
	sources = import ../../npins;
	pkgs = import sources.nixpkgs {};
in
{
	imports = 												# For now, if applying to other systems, swap files
		[( import ./hardware-configuration.nix )] ++		# Current system hardware config @ /etc/nixos/hardware-configuration.nix
		( import ../../modules/desktop ) ++
		( import ../../modules/hardware );					# Hardware devices
		
		boot = {											# Boot options
			kernelPackages = pkgs.linuxPackages_latest;
		#	initrd.kernelModules = [ "nouveau" ];			# Video drivers

			loader = {
				systemd-boot = {
					enable = true;
					consoleMode = "1";
				};
				efi = {
					efiSysMountPoint = "/boot";
				};
				timeout = 7;								# Auto select time
			};
		};

		hardware.sane = {									# Used for scanning with Xsane
			enable = true;
			extraBackends = [ pkgs.sane-airscan ];
		};

		environment = {										# Packages installed system wide
			systemPackages = [ pkgs.simple-scan ];
		};

		services = {
			blueman.enable = true;							# Bluetooth
			printing = {									# Printing
				enable = true;
				drivers = [ pkgs.hplip ];
			};
			avahi = {										# Needed for wireless printers
				enable = true;
				nssmdns = true;
				publish = {									# Needed for detecting scanner
					enable = true;
					addresses = true;
					userServices = true;
				};	
			};
			samba = {
				enable = true;								# Don't forget to set a password: $smbpasswd -a <user>
				shares = {
					share = {
						"path" = "/home/${user}";
						"guest ok" = "yes";
						"read only" = "no";
					};
				};
				openFirewall = true;
			};
		};

		inherit lite-xl-git;
}
