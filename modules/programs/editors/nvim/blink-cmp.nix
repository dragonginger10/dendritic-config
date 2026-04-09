{
  flake.modules.nixvim.base.plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "super-tab";
      signature.enabled = true;
      completion.documentation.auto_show = true;
      sources = {
        providers = {
          spell = {
            module = "blink-cmp-spell";
            name = "Spell";
            score_offset = 100;
          };
        };

        default = [
          "lsp"
          "path"
          "buffer"
          "spell"
        ];
      };
    };
  };
}
