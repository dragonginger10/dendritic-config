{
  flake.modules.nixos.syncthing =
    { config, ... }:
    let
      user = config.preferences.user.name;
      docs = "${config.users.users.${user}.home}/Documents";
    in
    {
      services.syncthing = {
        enable = true;
        inherit user;
        group = "users";
        dataDir = "${docs}/sync";
        settings = {
          folders = {
            Projects = {
              id = "my-projects-dir";
              path = "${docs}/Projects";
              devices = [ "work" ];
            };
            EPUB = {
              id = "hye6a-atsqh";
              path = "${docs}/EPUB";
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
