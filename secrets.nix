let
  pretender = "ssh-ed25519
  AAAAC3NzaC1lZDI1NTE5AAAAIH+GK31SHiBi9BDrcg0LocwSQ6psdxrCINPqcKKiACCE
  20241011_git_nixos_faker";
  manager1 = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAEkqsFH9XjlXDzeGs7z8My+Zbvev/NHaDiJA6GmojFSmwhxJrTwHss162VWVgF9JmSP3uQyqe03ikW0wl5imANlxAAiTbaMjz9y2sThVeu7t7aKHnNpbXQDI23+Qe/oelx7BWFH32w0SP+J4jfkHIAuXe14dcy1eXWSrJgSovpr8MO3ww== pretender@underblade";
in {
  "secret1.age".publicKeys = [pretender];
  "secret2.age".publicKeys = [manager1];
}
