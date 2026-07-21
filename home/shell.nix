{ ... }:

{
  programs = {

    fzf.enable = true;

    zoxide.enable = true;

    bat.enable = true;

    eza.enable = true;

    tmux.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        size = 10000;
        path = "$HOME/.zsh_history";
      };
    };

  };
}
