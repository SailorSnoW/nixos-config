{
  services.podman.enable = true;

  virtualisation.oci-containers.containers = {
    speedtest-tracker = {
      image = "ghcr.io/alexjustesen/speedtest-tracker:latest";
      ports = [ "8080:80" "8443:443" ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        DB_CONNECTION = "mysql";
        DB_HOST = "db";
        DB_PORT = "3306";
        DB_DATABASE = "speedtest_tracker";
        DB_USERNAME = "speedy";
        DB_PASSWORD = "password";
        TZ = "Europe/Paris";
      };
      volumes = [
        "/etc/localtime:/etc/localtime:ro"
        "/var/lib/containers/data/speedtest_tracker/config:/config"
        "/var/lib/containers/data/speedtest_tracker/web:/etc/ssl/web"
      ];
      autoStart = true;
      extraOptions = [ "--name=speedtest-tracker" ];
      restartPolicy = "unless-stopped";
      dependsOn = [ "db" ];
    };

    db = {
      image = "docker.io/library/mariadb:10";
      environment = {
        MARIADB_DATABASE = "speedtest_tracker";
        MARIADB_USER = "speedy";
        MARIADB_PASSWORD = "password";
        MARIADB_RANDOM_ROOT_PASSWORD = "true";
      };
      volumes = [
        "/var/lib/containers/data/speedtest-db:/var/lib/mysql"
      ];
      autoStart = true;
      restartPolicy = "always";
    };
  };
}
