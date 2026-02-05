{ config, ... }:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = {
        enable = true;
        dates = "monthly";
      };
    };
    containers.containersConf.settings = {
      containers = {
        userns = "auto";
      };
    };
    oci-containers.backend = "podman";
  };
  # UIDs that podman can use for container users
  users = {
    groups.containers = { };
    users.containers = {
      isSystemUser = true;
      group = "containers";
      subUidRanges = [
        {
          count = 1000000000;
          startUid = 2000000000;
        }
      ];
      subGidRanges = [
        {
          count = 1000000000;
          startGid = 2000000000;
        }
      ];
    };
  };

  systemd.tmpfiles.settings."mssql-state"."/var/mssql".d = {
    user = "-";
    group = "-";
    mode = "774";
  };

  sops = {
    secrets =
      let
        mssqlService = config.virtualisation.oci-containers.containers.mssql.serviceName;
      in
      {
        "mssql-key".restartUnits = [ mssqlService ];
        "mssql-sa-password".restartUnits = [ mssqlService ];
      };
    templates."mssql-config.txt" = {
      mode = "0400";
      content = ''
        ACCEPT_EULA=Y
        MSSQL_SA_PASSWORD=${config.sops.placeholder."mssql-sa-password"}
        MSSQL_PID=${config.sops.placeholder."mssql-key"}
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 1433 ];
  virtualisation.oci-containers.containers.mssql = {
    privileged = false;
    environmentFiles = [ config.sops.templates."mssql-config.txt".path ];
    extraOptions = [
      "--userns=auto"
      "--network=private"
    ];
    ports = [
      "1433:1433/tcp" # Default instance running over TCP
      "1434:1434/tcp" # Dedicated Admin Connection
      # "433:433/tcp" # HTTPS
    ];

    image = "mcr.microsoft.com/mssql/server:2019-latest";
    pull = "newer";
    volumes = [ "/var/mssql:/var/opt/mssql:U" ];
  };
}
