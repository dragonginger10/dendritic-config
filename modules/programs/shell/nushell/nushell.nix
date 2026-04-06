{
  flake.modules.homeManager.nushell =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) getExe readFile;
    in
    {
      home = {
        sessionVariables.SHELLS = getExe pkgs.nushell;
        shell.enableNushellIntegration = true;

        shellAliases = {
          cp = "cp --recursive == verbose";
          mk = "mkdir";
          rm = "rm --recursive --verbose";
          x = "eza --icons";
          xa = "eza --icons --all";
          xl = "eza --long";
          xla = "eza --long --all";
          xt = "eza --tree --icons";
          xta = "eza --tree --icons --all";
          ping = "gping";
          ll = "ls -la";
          l = "ls -l";
          j = "just";
          gc = "git commit";
          ga = "git add";
          gs = "git status";
          gp = "git push";
          gu = "git pull";
          gd = "git diff";
          gb = "git branch";
          gi = "git init";
          gcl = "git clone";
          gl = ''
            git log --all --graph --pretty format: '%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'
          '';
          g = "lazygit";
          py = "python";
        };

        packages = with pkgs; [
          eza
        ];
      };

      programs = {
        carapace.enable = true;
        starship.enable = true;
        zoxide.enable = true;

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };

      programs.nushell = {
        enable = true;
        configFile.file = ./config.nu;
        plugins = with pkgs.nushellPlugins; [
          polars
        ];
      };
    };
}
