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
      type = lib.types.string;
      description = "Your Riot API Key";
    };

    discordToken = lib.mkOption {
      type = lib.types.string;
      description = "Your Discord Bot Token";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.tentrackule = {
      description = "Tentrackule Discord Bot Daemon";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.tentrackule}/bin/tentrackule";
        Restart = "always";
        Type = "simple";
        DynamicUser = "yes";
      };
      environment = {
        RIOT_API_KEY = toString config.services.tentrackule.riotApiKey;
        DISCORD_BOT_TOKEN = toString config.services.tentrackule.discordToken;
      };
    };
  };
}
