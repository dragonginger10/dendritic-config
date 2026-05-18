# Dendritic Config

My NixOS and Home-Manager configuration monorepo. Covers a Wayland-first desktop (Niri compositor) and laptop, a gaming-capable setup with Steam + GPU recording, and a Nushell + Neovim development environment — all declared in one place.

## What's Configured

| Area | Tools |
|------|-------|
| Shell & CLI | Nushell, Starship (eldritch theme), Zoxide, Carapace, Tmux, Eza, Direnv |
| Editor | Neovim (nixvim) — LSP, Treesitter, Telescope, Blink completions; Micro |
| Desktop | Niri (Wayland compositor), Stylix theming, custom Plymouth splash, Ghostty terminal |
| Gaming | Steam + Proton + SteamTinkerLaunch, Gamemode, GPU Screen Recorder, CloneHero, Prism Launcher |
| Apps | Zen Browser, Discord + discover-overlay, Mattermost, Flatpak |
| Dev tooling | Claude Code, Direnv, nix-gaming cachix |
| Custom packages | eldritch-starship, dracula-plymouth, fastfetch-eldritch, glazepkg |

## Directory Structure

```
dendritic-config/
├── flake.nix              # Flake entry point using flake-parts
├── .justfile              # Just command runner recipes
├── modules/
│   ├── hosts/             # Machine-specific NixOS configurations
│   │   ├── phos/
│   │   ├── wonderland/
│   │   ├── mini/
│   │   └── wsl/
│   ├── users/             # User-specific home-manager + NixOS options
│   │   └── dragon/
│   ├── programs/          # Application configurations
│   │   ├── editors/       # Neovim (nixvim), Micro
│   │   ├── shell/         # Nushell, Tmux, Git, Starship, Zoxide
│   │   ├── gaming/        # Steam, GPU recorder, game tools
│   │   └── niri.nix       # Wayland compositor config
│   ├── system/            # System-wide NixOS modules
│   │   ├── base/
│   │   ├── boot.nix
│   │   ├── desktop.nix
│   │   ├── fonts.nix
│   │   ├── sound.nix
│   │   ├── stylix.nix
│   │   └── nix/
│   ├── services/          # System services (e.g. Flatpak)
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

[Just](https://just.systems) is used as the command runner for this project. Most commands use [nh](https://github.com/nix-community/nh) to simplify Nix operations and remove the need for sudo.

```bash
just switch        # fmt + check + build + activate (current host)
just switch phos   # same, targeting a specific host
just home          # switch home-manager config for current user
just test          # dry-run build to check for errors
just vm            # build and launch a VM for the current host
just up            # update flake inputs
just --list        # full command reference
```


## Hosts

| Host | Type | DE / Compositor | Notable extras |
|------|------|-----------------|----------------|
| phos | Desktop | Niri (Wayland) | Steam, GPU Screen Recorder, Claude Code, gaming modules |
| wonderland | Laptop | COSMIC | Slack, no gaming modules |
| mini | VM | LXQT + LightDM | Minimal config for testing |
| wsl | WSL | headless | NixOS-WSL integration |

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
- [nh](https://github.com/nix-community/nh)
- [flake-file](https://flake-file.oeiuwq.com/)
- [pkgs-by-name](https://github.com/drupol/pkgs-by-name-for-flake-parts)
- [treefmt-nix](https://github.com/numtide/treefmt-nix)
- [git-hooks.nix](https://github.com/cachix/git-hooks.nix)
- [NixOS-WSL](https://github.com/nix-community/NixOS-WSL)
- [nix-gaming](https://github.com/fufexan/nix-gaming)
- [Determinate Nix](https://determinate.systems/)
