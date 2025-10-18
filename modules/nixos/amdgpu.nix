{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa.opencl
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

  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}
