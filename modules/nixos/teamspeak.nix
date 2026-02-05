{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    teamspeak3
  ];
}
