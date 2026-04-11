let
  dragonPhos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsuTYhZ1XsXb+d/Pyph7RpkPYnE3R4xV9Usl5aH6Ood";
in
{
  "dragon.age".publicKeys = [ dragonPhos ];
}
