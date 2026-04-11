{ inputs, lib, ... }:
{
  flake-file.inputs = {
    ragenix.url = lib.mkDefault "github:yaxitech/ragenix";
    secrets = {
      url = "path:../../secrets/";
      flake = false;
    };
  };

  flake.modules.nixos.ragenix =
    { pkgs, config, ... }:
    {
      imports = [ inputs.ragenix.nixosModules.default ];

      config = {
        age.secrets.sneaky.file = inputs.secrets + /sneaky.age;
        age.identityPath = ["/home/dragon/.ssh/id_ed25519"];
      };
    };
}
