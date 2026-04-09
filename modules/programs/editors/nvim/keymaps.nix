{
  flake.modules.nixvim.base.keymaps = [
    {
      key = ";";
      action = ":";
    }
    {
      mode = "n";
      key = "<leader>pv";
      action = "<cmd>Yazi<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>HopWord<CR>";
      options.silent = true;
    }
  ];
}
