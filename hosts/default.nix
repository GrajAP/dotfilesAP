{
  nixpkgs,
  self,
  ...
}: let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  hw = inputs.nixos-hardware.nixosModules;
  ragenix = inputs.ragenix.nixosModules.age;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core ragenix];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.GrajAP = ../modules/home;
  };
in {
  AP = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "AP";}
        ./AP/hardware-configuration.nix
        bootloader
        nvidia
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
