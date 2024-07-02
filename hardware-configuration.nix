{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Boot options
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Paritions
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8e0f73b6-1aee-4004-94f9-8711ace22881";
      fsType = "ext4";
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/86B1-8A03";
      fsType = "vfat";
    };

  # Swap
  swapDevices = [
      {
        device = "/swapfile";
        size = 32768; # Size in MB
      }
  ];

  # OTD
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = {
  	enable = true;
	enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
	modesetting.enable = true;
	powerManagement.enable = false;
	nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
