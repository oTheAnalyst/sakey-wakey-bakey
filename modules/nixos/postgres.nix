pkgs: {
  # ...
  services.postgresql = {
    enable = true;
    ensureDatabases = ["mydatabase"];
    authentication = pkgs.lib.mkOverride 10 ''
      # type database  DBuser  auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      host  all      postgres   0.0.0.0/0  trust
      # ipv6
      host  all      all     ::1/128        trust
    '';
  };
}
