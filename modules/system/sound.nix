{
  flake.modules.nixos.sound = {
    services.pipewire = {
    alsa.enable = true;
    alsa.support32bit = true;
    pulse.enable = true;
    enable = true;
  };
    security.rtkit.enable = true;
  };
}
