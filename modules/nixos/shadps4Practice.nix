{
  appimageTools,
  fetchurl,
  runCommand,
  unzip,
  ...
}: let
  pname = "shadPS4QtLauncher";
  rev = "bf2c711d3e508671fe9b6b417355defff1fb6237";
  version = "2026-09-01-bf2c711";

  zipSrc = fetchurl {
    url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-2026-09-01-${rev}/shadPS4QtLauncher-linux-qt-${version}.zip";
    hash = "sha256-1BjPYj9sdE0d7VMgF+ojGg/vdAeCuFBzMkLjhBF9NSg=";
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
