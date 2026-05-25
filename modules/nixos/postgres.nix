   {pkgs, ...}:{
  services = {
    #    cloudflared = {
    #      enable = true;
    #      tunnels = {
    #        "772b8617-b3d7-4cc8-91c6-16ec0effcd04" = {
    #          credentialsFile = "/etc/cloudflared/772b8617-b3d7-4cc8-91c6-16ec0effcd04.json";
    #          default = "http_status:404";
    #          ingress = {
    #            "pg-demon-1.sakey.app" = "tcp://localhost:80";
    #          };
    #        };
    #      };
    #    };
    postgresql = {
      enable = true;
      ensureDatabases = ["mydatabase"];
      enableTCPIP = true;
      settings.port = 5432;
      authentication = pkgs.lib.mkOverride 10 ''
        # type database  DBuser  auth-method
        local all       all     trust
        # ipv4
        host  all      all     127.0.0.1/32   trust
        host  all      all     100.64.0.0/10   trust
        host  all      all     100.64.0.0/10   md5
        # ipv6
        host  all      all     ::1/128        trust
      '';
      extensions = ps: with ps; [postgis pg_repack];
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
        CREATE DATABASE nixcloud;
        GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
      '';
      package = pkgs.postgresql_18;
    };
  };
##    networking.firewall.allowedTCPPorts = [5432 65010];
}
