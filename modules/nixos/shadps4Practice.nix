{
  appimageTools,
  fetchurl,
  runCommand,
  unzip,
  ...
}: let
  pname = "shadps4";
  version = "224";

  zipSrc = fetchurl {
    url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/v${version}/shadPS4QtLauncher-linux-qt-v${version}.zip";
    hash = "sha256-CMPG2mSizqHURwE5q5OI3iQoKYBu2HoI6mOTHgExyxc=";
  };

  appimageSrc =
    runCommand "${pname}-${version}-extracted.AppImage"
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
