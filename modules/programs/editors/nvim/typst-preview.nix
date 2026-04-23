{
  flake.modules.nixvim.base = {
    plugins.typst-preview = {
      enable = true;
      settings = {
        port = 9999;
        dependencies_bin = {
          tinymist = "tinymist";
          websocat = "websocat";
        };
      };
    };
  };
}
