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
        hostPubkey = builtins.elemAt config.preferences.keys 0;
        storageMode = "local";
        masterIdentities = [ ../../.secrets/age-yubikey-identity.pub ];
        localStorageDir = ../.././secrets/${config.networking.hostName};
      };
    };
}
