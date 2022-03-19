{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
        "docker"
        "git-flow"
        "history-substring-search"
        "python"
      ];
      theme = "frisk";
    };
    history = {
      path = config.programs.zsh.dotDir + "/.zsh_history";
      share = true;
      save = 10000000;
      ignoreDups = true;
      extended = true;
      size = 10000000;
    };
    shellAliases = with pkgs; {
      d = "direnv";
      dr = "direnv reload";
      la = "exa -lah";
      l = "exa -lh";
      f = "rg --files";
      E = "env SUDO_EDITOR=\"emacsclient\" sudo -e";
      e = "emacsclient";
      em = "emacs";
      cp = "cp -i";
      mv = "mv -i";
      gst = "${pkgs.gst}/bin/gst";
      cdghq = "cd $(ghq root)/$(ghq list | peco)";
      cdgst = "cd $(gst --short | peco)";
      ##update Nixpkgs
      fp = "git fetch && git pull";
      ag0 = "rg --max-depth=1";
    };
    plugins = [
      {
        name = "fzf-zsh";
        src = pkgs.fzf-zsh;
      }
      {
        name = "zsh-fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
      }
      {
        name = "zsh-bd";
        src = pkgs.zsh-bd;
      }
      {
        name = "nix-zsh-completions";
        src = pkgs.nix-zsh-completions;
      }
      {
        name = "zsh-256color";
        src = pkgs.fetchFromGitHub {
          owner = "chrissicool";
          repo = "zsh-256color";
          rev = "9d8fa1015dfa895f2258c2efc668bc7012f06da6";
          sha256 = "14pfg49mzl32ia9i9msw9412301kbdjqrm7gzcryk4wh6j66kps1";
        };
      }
    ];
  };
}
