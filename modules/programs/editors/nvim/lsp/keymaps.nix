{ inputs, ... }:
{
  flake.modules.nixvim.base.lsp.keymaps = [

    {
      key = "gd";
      lspBufAction = "definition";
    }
    {
      key = "gD";
      lspBufAction = "references";
    }
    {
      key = "gt";
      lspBufAction = "type_definition";
    }
    {
      key = "gr";
      lspBufAction = "rename";
    }
    {
      key = "K";
      lspBufAction = "hover";
    }
    {
      key = "ga";
      lspBufAction = "code_action";
    }
    {
      key = "<leader>gf";
      lspBufAction = "format";
    }
    {
      key = "<leader>ht";
      action = inputs.nixvim.lib.nixvim.mkRaw ''
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end
      '';
      options.desc = "Toggle inlay hints";
    }
  ];
}
