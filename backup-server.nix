{ inputs, system }:  # Import-time arguments
{ config, lib, pkgs, ... }:  # Module-time arguments
let
  inherit (lib) mkEnableOption mkOption types;
  backup = inputs.self.packages.${system}.backup;
  cfg = config.services.cln-bkp-srv;
in
{
    options = {
    services.cln-bkp-srv = {
      enable = mkEnableOption "cln-bkp-srv, a server that stores the backup of a CLN sqlite db";

      bkpfile = mkOption {
        description = "Path to file.bkp file";
        #default = "cln-bkp-srv";
        type = types.str;
      };

      host = mkOption {
        description = "The host cln-bkp-srv binds to.";
        default = "127.0.0.1";
        example = "0.0.0.0";
        type = types.str;
      };

      port = mkOption {
        description = "The TCP port cln-bkp-srv will listen on.";
        default = 8000;
        type = types.port;
      };

      user = mkOption {
        description = "User account under which cln-bkp-srv runs.";
        default = "cln-bkp-srv";
        type = types.str;
      };

      group = mkOption {
        description = "Group under which cln-bkp-srv runs.";
        default = "cln-bkp-srv";
        type = types.str;
      };

      openFirewall = mkOption {
        description = "Open ports in the firewall for the cln-bkp-srv web interface.";
        default = false;
        type = types.bool;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.cln-bkp-srv = {
      description = "a server that stores the backup of a CLN sqlite db";

      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ backup ];
      preStart = ''
        if [ ! -e "${cfg.bkpfile}" ]; then
            echo "Initializing backup: ${cfg.bkpfile} not found."
            "${backup}/bin/backup-cli" init "file://${cfg.bkpfile}"
        else
            echo "Backup file already exists, skipping initialization."
        fi
      '';
      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${backup}/bin/backup-cli server file://${cfg.bkpfile} ${cfg.host}:${toString cfg.port}";
        Restart = "on-failure";
      };
    };

    /*users.users = mkIf (cfg.user == "cln-bkp-srv") {
      cln-bkp-srv = {
        isSystemUser = true;
        group = cfg.group;
        home = "/var/lib/${cfg.dataDir}";
      };
    };

    users.groups = mkIf (cfg.group == "cln-bkp-srv") {
      cln-bkp-srv = { };
    }; */

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };
  };



}