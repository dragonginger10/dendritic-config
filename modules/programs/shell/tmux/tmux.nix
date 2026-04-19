{
  flake.modules.homeManager.tmux =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;
        keyMode = "vi";
        shortcut = "C-Space";
        baseIndex = 1;
        escapeTime = 10;
        terminal = "tmux-256color";
        shell = "nu";
        plugins = with pkgs.tmuxPlugins; [
          sensible
          battery
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
}
