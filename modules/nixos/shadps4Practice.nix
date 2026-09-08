{
  appimageTools,
  fetchurl,
  runCommand,
  unzip,
  ...
}: let
  pname = "shadPS4QtLauncher";
  rev = "05f02f9ab4e554ed526585cbc1728f841673fd6e";
  version = "2026-09-11-05f02f9";
  date = "2026-09-11";

  zipSrc = fetchurl {
    url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-${date}-${rev}/shadPS4QtLauncher-linux-qt-${version}.zip";
    hash = "sha256-r/lZjgx8NKqNFV8qsO+foM41du/MeRj8CqaZyRlkL58=";
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
