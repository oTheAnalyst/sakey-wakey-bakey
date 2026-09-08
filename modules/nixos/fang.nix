{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############
    #fang apps
    ############
    microsoft-edge
    spotify
  ];
}
