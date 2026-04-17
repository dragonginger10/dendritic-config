{
  flake.module.nixos.tmux =
    { pkgs, ... }:
    {
      config = {
        progams.tmux = {
          enable = true;
          keymode = "vi";
          shortcut = "C-Space";
          baseIndex = 1;
          escapeTime = 10;
          terminal = "tmux-256color";
          plugins = with pkgs.tmuxPlugins; [
            sensible

          ];
          extraConfig = ''
            set-option -sa terminal-overrides ",xterm*:Tc"

            bind h select-pane -L
            bind j select-pane -D
            bind k select-pane -U
            bind l select-pane -R

            bind - split-window -v -c "#{pane_current_path}"
            bind | split-window -h -c "#{pane_current_path}"
          '';
        };
      };
    };
}
