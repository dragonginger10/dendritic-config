{
  flake.module.nixos.tmux = {
    config = {
      progams.tmux = {
        enable = true;
        keymode = "vi";
        shortcut = "z";
        baseIndex = 1;
        escapeTime = 10;
        terminal = "tmux-256color";
        # plugins = with pkgs.tmuxPlugins; [];
        extraConfig = ''
          bind - split-window -v -c "#{pane_current_path}"
          bind | split-window -h -c "#{pane_current_path}"
        '';
      };
    };
  };
}
