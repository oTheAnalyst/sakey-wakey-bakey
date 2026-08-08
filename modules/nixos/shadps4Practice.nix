{
  appimageTools,
  fetchurl,
  runCommand,
  unzip,
  ...
}: let
  pname = "shadPS4QtLauncher";
  rev = "a12b988ef35d98f2222a614c05498b27fef87121";
  version = "2026-08-08-a12b988";

  zipSrc = fetchurl {
    url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-2026-08-08-${rev}/shadPS4QtLauncher-linux-qt-${version}.zip";
    hash = "sha256-P8r0mhAJSfrcwVmr4wKzaoz7sw2m/2zquKfUAOvX10g=";
  };

  appimageSrc =
    runCommand "${pname}-qt.AppImage"
    {
      nativeBuildInputs = [unzip];
    }
    ''
      unzip ${zipSrc}

      cp shadPS4QtLauncher-qt.AppImage $out
    '';
in
  appimageTools.wrapType2 {
    inherit pname version;
    src = appimageSrc;
    extraPkgs = pkgs: [pkgs.at-spi2-core];
  }
