{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "sairajbuilds";
        email = "sairajssawant@proton.me";
      };

     delta = {
       enable = true;

       options = {
         line-numbers = true;
         navigate = true;
         side-by-side = true;
       };
      };

      init.defaultBranch = "main";

      pull.rebase = false;

      push.autoSetupRemote = true;

      core = {
        editor = "nvim";
        pager = "delta";
      };

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate --all";
        last = "log -1 HEAD";
        unstage = "restore --staged";
        aa = "add .";
        cm = "commit -m";
        sw = "switch";
        rb = "rebase";
      };
    };
  };
}
