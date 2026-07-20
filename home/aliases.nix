{
  home.shellAliases = {
    ll = "eza -lah";
    ls = "eza";
    cat = "bat";
    grep = "rg";
    ".." = "cd ..";
    "..." = "cd ../..";
    rebuild = "darwin-rebuild switch --flake ~/nix-config";
  };
}
