{
  flake.modules.nixvim.base.plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<C-p>" = "git_files";
    };
  };
}
