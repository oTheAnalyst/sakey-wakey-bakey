{pkgs, ...}: {
  hardware = {
    amdgpu.amdvlk.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        driversi686Linux.amdvlk
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    videoDrivers = ["amdgpu"];
  };
}
