{
  flake.modules.nixos.syncthing = { config, ... }: {
    services.syncthing = {
      enable = true;
      user = "dragon";
      group = "users";
      dataDir = "/home/dragon/Documents/sync";
      settings = {
        folders = {
          Projects = {
            id = "my-projects-dir";
            path = "/home/dragon/Documents/Projects";
            devices = [ "work" ];
          };
          EPUB = {
            id = "hye6a-atsqh";
            path = "/home/dragon/Documents/EPUB";
            devices = [
              "phone"
              "work"
            ];
          };
        };
        devices = {
          work.id = "CWIA4BV-M5K62A2-L3WNCU2-XLK6Z7L-CYBZO5W-XYWCNL7-UGCSE5N-7CNQRQP";
          phone.id = "O7TOAXZ-57MA4CP-MCGRUL7-QOTU4RK-VYRZ4DI-UXR2HXK-HFVD7DD-GZULCAP";
        };
      };
    };
  };
}
