{
  appimageTools,
  fetchurl,
  runCommand,
  unzip,
  ...
}: let
  pname = "shadPS4QtLauncher";
  rev = "ded9bb828331067cba3865a355b08859c324bc4c";
  version = "2026-09-23-ded9bb8";
  date = "2026-09-23";

  zipSrc = fetchurl {
    url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-${date}-${rev}/shadPS4QtLauncher-linux-qt-${version}.zip";
    hash = "sha256-e4Fa3UP3sWorORw4BF3sxhQOvk7CMBFT2B2lFhiiia4=";
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
