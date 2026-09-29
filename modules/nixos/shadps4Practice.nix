{
  appimageTools,
  fetchurl,
  runCommand,
  unzip,
  ...
}: let
  pname = "shadPS4QtLauncher";
  rev = "4c4e1090ea53dc1ec956fa9954acbf143d104b2e";
  version = "2026-10-02-4c4e109";
  date = "2026-10-02";

  zipSrc = fetchurl {
    url = "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-${date}-${rev}/shadPS4QtLauncher-linux-qt-${version}.zip";
    hash = "sha256-P3zF7P7116VF8f3T/oQ1rIw6hzSkF2eg2q5oaOu5hgE=";
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
