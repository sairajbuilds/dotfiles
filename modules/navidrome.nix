{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    navidrome
  ];
}
