{ ... }: {
  let
    shadps4 = builtins.path = { path = ./shadps4.AppImage; name = shadps4; };
  in
  pkgs.symlinkJoin {
    name = "shadps4";
    paths = [ pkgs.appimage-run ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      mv $out/bin/appimage-run $out/bin/shadps4
      wrapProgram $out/bin/shadps4 --add-flags "${shadps4}"
    '';
      };
  }
