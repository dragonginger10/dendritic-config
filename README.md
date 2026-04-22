# Dendritic Config

My NixOS and Home-Manager configuration monorepo. All my system configurations in one place.

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   phos      │     │wonderland  │     │   mini     │
│ (desktop)   │     │ (desktop)  │     │  (VM)     │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                   │
       └─────────┬─────────┴─────────┬─────────┘
                 │                   │
                 ▼                   ▼
         ┌──────────────┐    ┌──────────────┐
         │   system    │    │   programs  │
         │  (base, nix │◄───│  (niri,    │
         │   boot,     │    │   nvim,    │
         │   desktop)  │    │  nushell)  │
         └────────────┘    └─────┬──────┘
                                 │
                                 ▼
                        ┌──────────────┐
                        │    user     │
                        │  (dragon)  │
                        │ (home-mgr) │
                        └────────────┘
```

Each host imports a stack of modules. The user module (`dragon`) provides home-manager configuration layered on top.

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
│   ├── system/            # System-wide NixOS modules
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

This flake uses [flake-parts](https://flake.parts) combined with [import-tree](https://github.com/vic/import-tree) for automatic module discovery.

### Module System

- **`lib/nixos-hosts.nix`** - Defines the `nixosHosts` option. Each host is a NixOS system built by composing modules.
- **`lib/home-configs.nix`** - Defines the `homeConfigs` option. Each user gets a home-manager configuration.

### Host Definition

Hosts are defined in `modules/hosts/<name>/<name>.nix`:

```nix
{
  nixosHosts.phos.enable = true;

  flake.modules.nixos."confs/phos" = { pkgs, lib, ... }: {
    imports = with self.modules.nixos; [
      base
      nix
      boot
      desktop
      # ...
    ];
  };
}
```

The module imports from `self.modules.nixos.*` are auto-discovered by import-tree.

### Flake Outputs

The flake produces:
- `flake.nixosConfigurations` - All defined NixOS systems
- `flake.homeConfigurations` - All defined home-manager configs
- `flake.packages.*` - Custom packages

## Usage

### Build a Host

```bash
# Build phos system
nix build .#nixosConfigurations.phos.config.system.build.toplevel

# Build phos home-manager
nix build .#homeConfigurations.dragon.config.system.build.toplevel
```

### Switch a Host (live)

```bash
# Switch phos to new config
sudo nix --accept-flake-config run github:nix-community/nixos-rebuild -- switch --flake .#phos

# Switch dragon's home-manager
home-manager switch --flake .
```

### Development

```bash
# Check all outputs
nix flake check

# Show outputs
nix flakes show

# Update dependencies
nix flake update

# Format nix files
nix fmt
```

## Hosts

| Host | Type | Description |
|------|------|-------------|
| phos | Desktop | Main desktop machine |
| wonderland | Desktop | Secondary desktop |
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

       # host-specific config
       networking.hostName = "<name>";
       system.stateVersion = "25.11";
     };
   }
   ```

3. Add the host to activation if needed in `modules/system/base/activation.nix`

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
nix build .#nixosConfigurations.mini.config.system.build.toplevel
```

## Credits

Built with [flake-parts](https://flake.parts), [import-tree](https://github.com/vic/import-tree), [home-manager](https://github.com/nix-community/home-manager), [nixvim](https://github.com/nix-community/nixvim), and [stylix](https://github.com/nix-community/stylix).