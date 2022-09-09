{ config, lib, pkgs, modulesPath, ... }:

{
	imports = 
	[
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.consoleMode = "1";
	boot.loader.efi.efiSysMountPoint = "/boot";
	boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "uas" "sd_mod" ];
	boot.initrd.kernelModules = [ ];
	boot.initrd.luks.devices = {
		nixos = {
			device = "dev/disk/by-uuid/cdb3656c-a859-4f85-af53-8a327fcd48da";
		};
	};
	
	fileSystems."/" = {
		device = "/dev/mapper/nixos";
		fsType = "btrfs";
	};

	fileSystems."/boot" = {
		device = "dev/disk/by-label/boot";
		fsType = "vfat";
	};

	swapDevices = [
		{
			device = "/dev/disk/by-label/swap";
		}
	];

	networking = {
		hostName = "desktop";
		interfaces = {
			wlp3s0 = {
				useDHCP = true;
			};
		};
		networkmanager = {
			enable = true;
		};
		wireless = {
			enable = false;
		};
	};

	powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enable.RedistributableFirmware;
}
