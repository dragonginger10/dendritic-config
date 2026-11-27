{
  flake.modules.nixos.sound = {
    services.pipewire = {
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      enable = true;
    };
    security.rtkit.enable = true;
  };
}
