{ pkgs, ... }: {
  autocd = true;
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  enableSyntaxHighlighting  = true;

  history = {
    ignoreSpace = true;
    path = "$HOME/.zsh_history";
    size = 10000;
  };

  initExtra = "
    # History search
    autoload -U up-line-or-beginning-search
    autoload -U down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey -e
    bindkey '^[[A' up-line-or-beginning-search
    bindkey '^[[B' down-line-or-beginning-search
    bindkey '^r' history-incremental-search-backward

    # Jump words
    bindkey '^[[H' backward-word
    bindkey '^[[F' forward-word
    bindkey '^[[1;5D' backward-word
    bindkey '^[[1;5C' forward-word

    # Del key
    bindkey '\\e[3~' delete-char

    # Prompt
    autoload -Uz vcs_info
    autoload -U add-zsh-hook
    vcs_precmd() { vcs_info }
    add-zsh-hook precmd vcs_precmd
    setopt prompt_subst
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' unstagedstr '*'
    zstyle ':vcs_info:*' stagedstr '+'
    zstyle ':vcs_info:*' actionformats '%F{green}(%a%c%u%m)%f '
    zstyle ':vcs_info:*' formats '%F{green}(%b%c%u%m)%f '
    PROMPT='%B%F{blue}%(!.%1~.%~)%f \${vcs_info_msg_0_}%(!.#.$)%b '
  ";

  plugins = [
    {
      name = "zsh-history-substring-search";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-history-substring-search";
        rev = "v1.0.2";
        sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
      };
    }
  ];

  shellAliases = {
    # .files
    dotfiles = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
    # adb
    adbRestart = "adb shell stop && adb shell start";
    # cd
    "..." = "cd ../..";
    "...." = "cd ../../..";
    croot = "cd \"./\$(git rev-parse --show-cdup 2>/dev/null)\" 2> /dev/null";
    # git
    gitpick = "git cherry-pick";
    gitlg = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
    # grep
    grep = "grep --color=auto";
    # ls
    ls = "ls -1";
    # nix
    nix-chan = "nix-channel";
    nix-gc = "nix-collect-garbage -d";
    # open
    open-last = "open \$(find -s . -type f -maxdepth 1 | tail -n 1)";
    # rand-str
    rand-str = "LC_ALL=C tr -dc 'A-Za-z0-9!#$%&~' < /dev/urandom | head -c $1";
    # yt-dl
    yt-dl-mp3 = "youtube-dl --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'";
  };
}
