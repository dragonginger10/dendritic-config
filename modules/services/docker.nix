{
  flake.modules.nixos.docker =
    { config, ... }:
    let
      username = config.preferences.user.name;
    in
    {
      virtualisation.docker.enable = true;
      networking.firewall.trustedInterfaces = [ "docker0" ];
      users.users.${username}.extraGroups = [ "docker" ];
    };
}
