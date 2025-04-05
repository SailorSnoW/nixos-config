{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.tentrackule;
in
{
  options.services.tentrackule = {
    enable = lib.mkEnableOption "Enable Tentrackule Discord Bot";

    riotApiKey = lib.mkOption {
      type = lib.types.str;
      description = "Your Riot API Key";
    };

    discordToken = lib.mkOption {
      type = lib.types.str;
      description = "Your Discord Bot Token";
    };

    dbDir = lib.mkOption {
      type = lib.types.path;
      description = "Path to the wrote database files.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.tentrackule = {
      description = "Tentrackule Discord Bot Daemon";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.tentrackule}/bin/Tentrackule";
        Type = "simple";
        StateDirectory = "tentrackule";
        WorkingDirectory = "/var/lib/tentrackule";
        Restart = "on-failure";
        ProtectHome = true;
        ProtectSystem = "strict";
        PrivateTmp = true;
        PrivateDevices = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        NoNewPrivileges = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RemoveIPC = true;
        PrivateMounts = true;
        DynamicUser = true;
      };

      environment = {
        DB_PATH = toString config.services.tentrackule.dbDir;
        RIOT_API_KEY = toString config.services.tentrackule.riotApiKey;
        DISCORD_BOT_TOKEN = toString config.services.tentrackule.discordToken;
      };
    };

  };
}
