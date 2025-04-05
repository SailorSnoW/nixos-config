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
    systemd.services.tentrackule = rec {
      description = "Tentrackule Discord Bot Daemon";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.tentrackule}/bin/Tentrackule";
        Restart = "always";
        Type = "simple";
        User = "tentrackule";
        Group = "tentrackule";
      };

      preStart = ''
        install -d -m0700 -o ${serviceConfig.User} -g ${serviceConfig.Group} "/var/lib/tentrackule"
      '';
    };

    environment = {
      DB_PATH = toString config.services.tentrackule.dbDir;
      RIOT_API_KEY = toString config.services.tentrackule.riotApiKey;
      DISCORD_BOT_TOKEN = toString config.services.tentrackule.discordToken;
    };
  };
}
