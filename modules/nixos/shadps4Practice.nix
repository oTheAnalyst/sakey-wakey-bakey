{
  appimageTools,
  fetchurl,
  runCommand,
  unzip,
  ...
}: let
  pname = "shadPS4QtLauncher";
  rev = "88b34250839113dfdab1d3b8f1a7bfa559ea95e4";
  version = "2026-08-07-88b3425";

  zipSrc =
    fetchurl {
      url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-2026-08-07-${rev}/shadPS4QtLauncher-linux-qt-${version}.zip";
      hash = "sha256-hbLWhTbQN0fSIWo/Ykxs+AQnWmNvyCbDNzrFFt8evUQ=
";
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
