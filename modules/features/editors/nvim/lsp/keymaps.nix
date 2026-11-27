{ inputs, ... }:
{
  flake.modules.nixvim.base.lsp.keymaps = [

    {
      key = "<leader>gd";
      lspBufAction = "definition";
      options.desc = "go to definition";
    }
    {
      key = "<leader>gD";
      lspBufAction = "references";
      options.desc = "go to references";
    }
    {
      key = "<leader>gr";
      lspBufAction = "rename";
      options.desc = "rename symbol";
    }
    {
      key = "<leader>ga";
      lspBufAction = "code_action";
      options.desc = "code actions";
    }
    {
      key = "<leader>gf";
      lspBufAction = "format";
      options.desc = "lsp format";
    }
    {
      key = "<leader>gh";
      action = inputs.nixvim.lib.nixvim.mkRaw ''
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end
      '';
      options.desc = "Toggle inlay hints";
    }
  ];
}
