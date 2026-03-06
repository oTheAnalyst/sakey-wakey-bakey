{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    teamspeak3
  ];
    services.teamspeak3.enable = true;
  
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
    "ventoy-1.1.10"
  ];

}
