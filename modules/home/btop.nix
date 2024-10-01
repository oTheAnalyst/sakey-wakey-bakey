{ pkgs, ... }:
let
  btop-rocm = pkgs.btop.override { rocmSupport = true; };
in
{
home.packages = [ btop-rocm ];
 }
