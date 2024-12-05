{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;
    virtualHosts."julianlagoutte.fr".extraConfig = ''
      reverse_proxy 192.168.10.97:8080
    '';
    virtualHosts."www.julianlagoutte.fr".extraConfig = ''
      reverse_proxy 192.168.10.97:8080
    '';

    # Pterodactyl related
    virtualHosts."panel.snxw.moe".extraConfig = ''
      reverse_proxy 100.65.121.117:8081
    '';
    virtualHosts."wings1.snxw.moe".extraConfig = ''
      reverse_proxy 192.168.10.54:443
    '';
  };
}
