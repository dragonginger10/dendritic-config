{
  flake.schemas.wrapModules = {
    version = 1;
    doc = "Modules for Wrapper input";
    inventory = output: {
      children = builtins.mapAttrs (name: value: {
        what = "Wrapper Module";
      }) output;
    };
  };
}
