let
  wslDragon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1qC6hEuKv+i7m/s6ppfCmgVCaReSEGzA3I0OmVni+e nixos@nixos-wsl";
in
{
  "sneaky.age".publicKeys = [ wslDragon ];
}
