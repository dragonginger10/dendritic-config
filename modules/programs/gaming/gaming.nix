{ self, ... }:
{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      imports = [
        self.modules.nixos.steam
      ];

      nix.settings = {
        substituters = [ "https://nix-gaming.cachix.org" ];
        trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
      };

      environment.systemPackages = with pkgs; [
        bottles
        prismlauncher
      ];
    };
}
