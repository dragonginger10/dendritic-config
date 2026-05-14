{
  flake.modules.nixvim.base.plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "super-tab";
      signature.enabled = true;
      completion.documentation.auto_show = true;
      sources = {
        providers = {
        };

        default = [
          "lsp"
          "path"
          "buffer"
        ];
      };
    };
  };
}
