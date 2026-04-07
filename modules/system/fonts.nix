{
  flake.modules.nixos.fonts =
    { pkgs, config, ... }:
    {
      config.fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
        fira-code
        fira-code-symbols
        noto-fonts-cjk-serif
        notonoto
      ];
    };
}
