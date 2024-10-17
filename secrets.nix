let
  pretender = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+GK31SHiBi9BDrcg0LocwSQ6psdxrCINPqcKKiACCE 20241011_git_nixos_faker";
in {
  "secret1.age".publicKeys = [pretender];
}
