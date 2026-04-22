# Dendritic Config

My NixOS and Home-Manager configuration monorepo. All my system configurations in one place.

## Directory Structure

```
dendritic-config/
├── flake.nix              # Flake entry point using flake-parts
├── modules/
│   ├── hosts/             # Machine-specific NixOS configurations
│   │   ├── phos/
│   │   ├── wonderland/
│   │   ├── mini/
│   │   └── wsl/
│   ├── users/             # User-specific home-manager + NixOS options
│   │   └── dragon/
│   ├── programs/          # Application configurations
│   │   ├── editors/       # Neovim,etc
│   │   ├── shell/         # Nushell, tmux, git
│   │   ├── gaming/
│   │   └── niri.nix
│   ├── system/            # System-wide NixOS modules such as boot loader
│   │   ├── base/
│   │   ├── boot/
│   │   ├── desktop/
│   │   └── nix/
│   └── lib/               # Flake-parts module definitions
│       ├── nixos-hosts.nix    # Defines nixosHosts option
│       └── home-configs.nix   # Defines homeConfigs option
└── packages/              # Custom packages
```

## How It Works

This repo uses the [dendritic](https://github.com/mightyiam/dendritic) pattern.
Every file is its own module, which is either imported in to another module as
a submodule or into a host or user config. 

### helper modules

- **`lib/nixos-hosts.nix`** - Defines the `nixosHosts` option. All the boiler plate of a nixosConfiguration.
- **`lib/home-configs.nix`** - Defines the `homeConfigs` option. Creates both the user config for nixos and homeManager modules as well as a homeConfiguration

### Host Definition

Hosts are defined in `modules/hosts/<name>/<name>.nix`:

```nix
{
  nixosHosts.<host>.enable = true; # see lib/nixos-hosts.nix for module setup

  flake.modules.nixos."confs/<host>" = { pkgs, lib, ... }: {
    imports = with self.modules.nixos; [
      base
      nix
      boot
      # ...
    ];
  };
}
```

### Flake Outputs

The flake produces:
- `flake.nixosConfigurations` - All defined NixOS systems
- `flake.homeConfigurations` - All defined home-manager configs
- `flake.packages.*` - Custom packages
- `flake.app.*` - apps, specifically for [flake-file](https://flake-file.oeiuwq.com/)
- `flake.schemas.*` - Custom schema to allow checks and viewing of custom outputs

## Usage

[Just](https://just.systems) is used as the command runner for this project. A full list of command can be found by running `just --list`. Most of the commands utilize [nh](https://github.com/nix-community/nh) to simplify the nix builtin command and remove the need for sudo. 


## Hosts

| Host | Type | Description |
|------|------|-------------|
| phos | Desktop | Main desktop machine |
| wonderland | Desktop | laptop |
| mini | VM | Minimal test VM |
| wsl | WSL | Windows Subsystem for Linux |

## Adding a New Host

1. Create the host directory:
   ```bash
   mkdir -p modules/hosts/<name>
   ```

2. Create `modules/hosts/<name>/<name>.nix`:
   ```nix
   {
     self,
     ...
   }: {
     nixosHosts.<name>.enable = true;

     flake.modules.nixos."confs/<name>" = { pkgs, lib, ... }: {
       imports = with self.modules.nixos; [
         base
         nix
         boot
         desktop
         # add more modules...
       ];

       system.stateVersion = "25.11";
     };
   }
   ```

## Adding a New User

1. Create the user directory:
   ```bash
   mkdir -p modules/users/<username>
   ```

2. Create `modules/users/<username>/<username>.nix`:
   ```nix
   {
     self,
     lib,
     ...
   }: {
     homeConfigs.<username>.enable = true;

     flake.modules = lib.mkMerge [
       (self.lib.user <username> true)
       {
         nixos.<username> = {
           imports = with self.modules.nixos; [
             environment
             editors
             home-manager
           ];
         };
       }
       {
         homeManager.<username> = {
           imports = with self.modules.homeManager; [
             stylix
             shell
           ];
           home.stateVersion = "25.11";
         };
       }
     ];
   }
   ```

## Testing in VM

```bash
# Build mini VM
nh os build-vm --hostname <host> .#
```

## Credits

- [flake-parts](https://flake.parts) 
- [import-tree](https://github.com/vic/import-tree) 
- [home-manager](https://github.com/nix-community/home-manager) 
- [nixvim](https://github.com/nix-community/nixvim) 
- [stylix](https://github.com/nix-community/stylix)
- [flake-file](https://flake-file.oeiuwq.com/)
- [pkgs-by-name](https://github.com/drupol/pkgs-by-name-for-flake-parts)
- [treefmt-nix](https://github.com/numtide/treefmt-nix)
- [git-hooks.nix](https://github.com/cachix/git-hooks.nix)
- [NixOS-WSL](https://github.com/nix-community/NixOS-WSL)
- [Determinate Nix](https://determinate.systems/)
