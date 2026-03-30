let
  wslDragon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1qC6hEuKv+i7m/s6ppfCmgVCaReSEGzA3I0OmVni+e nixos@nixos-wsl";
  phosDragon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood dragon@phos";
in
{
  "sneaky.age".publicKeys = [ wslDragon phosDragon];
}
