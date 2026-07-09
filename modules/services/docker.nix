{
  flake.modules.nixos.docker =
    { config, ... }:
    let
      username = config.preferences.user.name;
    in
    {
      virtualisation.docker.enable = true;
      users.previlegedGroups = [ "docker" ];
      networking.firewall.trustedInterfaces = [ "docker0" ];
      users.users.${username}.extraGroups = [ "docker" ];
    };
}
