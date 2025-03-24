let
  pretender = "ssh-ed25519
  AAAAC3NzaC1lZDI1NTE5AAAAIH+GK31SHiBi9BDrcg0LocwSQ6psdxrCINPqcKKiACCE
  20241011_git_nixos_faker";
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFBjzSMscdSZEde0qeMm2udGht+0fQF0HPMIElPuTFP6 pretender@underblade";
  gknife = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDped2PCj6u9sHhYJkjjZsizvIr5gaMWGmkqBsdebSAc mcumbo@pm.me";
in {
  "secret1.age".publicKeys = [pretender];
  "s2.age".publicKeys = [user1];
  "s3.age".publicKeys = [gknife];
}
