{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [19999];
  
  nixpkgs.config.allowUnfree = true;

  services.netdata.package = pkgs.netdata.override {
    withCloudUi = true;
  };
  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "ram";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
    };
  };
}
