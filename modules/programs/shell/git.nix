{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "JP";
          email = "dragonginger10@gmail.com";
        };
        credential.helper = "store";
        init.defaultBranch = "main";
        core = {
          compression = 9;
          whitespace = "error";
          preloadindex = true;
        };
        advice = {
          addEmptyPathspec = false;
          pushNonFastForward = false;
          statusHints = false;
        };
        url = {
          "git@github.com:dragonginger10/".insteadOf = "dg:";
          "git@git.dragonlibrary.xyz:dragonginger/".insteadOf = "fg:";
          "git@github.com:".insteadOf = "gh:";
        };
        status = {
          branch = true;
          showStash = true;
          showUntrackedFiles = "all";
        };
        diff = {
          context = 3;
          renames = "copies";
          interHunContext = 10;
        };
        push = {
          autotupRemote = true;
          default = "current";
          followTags = true;
        };
        pull = {
          default = "current";
          rebase = true;
        };
        rebase = {
          autoStash = true;
          missingCommitsCheck = "warn";
        };
        log = {
          abrevCommit = true;
        };
      };
    };
  };
}
