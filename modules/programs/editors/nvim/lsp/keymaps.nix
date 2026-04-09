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
      action = "format";
    }
  ];
}
