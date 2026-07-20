{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "USERNAME";
        email = "EMAIL";
      };

      init.defaultBranch = "main";

      pull.rebase = false;

      push.autoSetupRemote = true;

      core.editor = "nvim";

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate --all";
      };
    };
  };
}
