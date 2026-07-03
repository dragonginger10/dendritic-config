{
  inputs,
  self,
  ...
}:
{
  flake-file.inputs = {
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.agenix-rekey.flakeModule
  ];

  flake.modules.nixos.agenix =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        (lib.mkAliasOptionModule [ "secrets" ] [ "age" "secrets" ])
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
      ];

      environment.systemPackages = [
        pkgs.rage
        pkgs.age-plugin-yubikey
      ];

      services.pcscd.enable = true;

      age.rekey = {
        hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos";
        storageMode = "local";
        masterIdentities = [ ../../.secrets/age-yubikey-identity.pub ];
        localStorageDir = ../.././secrets/${config.networking.hostName};
      };
    };
}
