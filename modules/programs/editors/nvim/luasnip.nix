{
  flake.modules.nixvim.base.plugins.luasnip = {
    enable = true;
    fromVscode = [
      { paths = ./snippets; }
    ];
  };
}
