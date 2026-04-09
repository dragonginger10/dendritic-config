{
  flake.module.nixvim.base = {
    globals.mapleader = " ";
    viAlias = true;
    opts = {
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
      conceallevel = 2;
    };
  };
}
