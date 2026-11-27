{
  flake.modules.nixos.grist =
    { config, ... }:
    let
      domain = "sheets.dragonslibrary.xyz";
      port = 8484;
      # Traefik puts the basic-auth username here; Grist signs that email in.
      authHeader = "X-Forwarded-User";
    in
    {
      secrets = {
        # GRIST_SESSION_SECRET=<long random string>
        gristEnv.rekeyFile = ./gristEnv.age;
        # htpasswd line(s) for Traefik basic auth; the username must be an email:
        # `htpasswd -nB you@example.com`
        gristAuth = {
          rekeyFile = ./gristAuth.age;
          mode = "0400";
          owner = "traefik";
          group = "traefik";
        };
      };

      # Native grist-core: listens on 127.0.0.1 only, documents sandboxed with gVisor.
      services.grist = {
        enable = true;
        environmentFiles = [ config.secrets.gristEnv.path ];
        environment = {
          PORT = toString port;
          APP_HOME_URL = "https://${domain}";
          # Forwarded-header login: Traefik authenticates, Grist trusts the header.
          # Safe only because Grist listens on 127.0.0.1 behind Traefik.
          GRIST_FORWARD_AUTH_HEADER = authHeader;
          # The forwarded email that is the instance admin.
          GRIST_DEFAULT_EMAIL = "dragonginger10@gmail.com";
          GRIST_TELEMETRY_LEVEL = "off";
        };
      };

      services.traefik.dynamicConfigOptions.http = {
        middlewares.grist-auth.basicAuth = {
          usersFile = config.secrets.gristAuth.path;
          removeHeader = true;
          headerField = authHeader;
        };
        services.grist.loadBalancer.servers = [
          { url = "http://127.0.0.1:${toString port}"; }
        ];
        routers.grist = {
          entryPoints = [ "websecure" ];
          service = "grist";
          rule = "Host(`${domain}`)";
          middlewares = [ "grist-auth" ];
        };
      };
    };
}
