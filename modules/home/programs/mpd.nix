{
  services.mpd = {
    enable = true;
    dataDir = "/home/pretender/musicDirectory";
    extraArgs = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
    network.listenAddress = "any";
  };
}
