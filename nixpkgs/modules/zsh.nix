{ pkgs, ... }: {

programs.zsh = {
  enable = true;
  dotDir = ".config/zsh";
  history.path = "${builtins.getEnv "HOME"}/.cache/zsh/history";

  sessionVariables = {
    VISUAL = "micro";
    EDITOR = "micro";
    MICRO_TRUECOLOR= "1";
    BAT_THEME = "Nord";
    TERM = "termite";
    TERMINAL = "termite";
  };

  shellAliases = {
    ls = "ls --color=auto";
    la = "ls --color=auto -A";
    diff = "diff --color=auto -u";
    dirdiff = "diff --color=auto -ENwbur";
    speedtest = "printf 'Ping: ' && ping google.com -c 1 | grep time= | cut -d'=' -f4 && ${pkgs.speedtest-cli}/bin/speedtest | grep -E 'Download|Upload'";
    mp3 = "mpv --no-video";
    update-system = "${builtins.getEnv "HOME"}/.scripts/update-system.sh";
    dotconfig = "micro \$(find ${builtins.getEnv "HOME"}/.config/ -type f | ${pkgs.fzf}/bin/fzf -m)";
    nano = "micro";
    user-install =  "/home/patryk/.config/nixpkgs/modules/user-install.sh";
  };

  plugins = [
    {
    name = "zsh-syntax-highlighting";
    src = pkgs.zsh-syntax-highlighting;
    file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
    }
    {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
        name = "zsh-autosuggestions";
	    src = pkgs.zsh-autosuggestions;
	    file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    }
  ];

  initExtra = ''
	source "/home/patryk/.cache/p10k-instant-prompt-patryk.zsh"
	
    autoload -U compinit
    zstyle ':completion:*' menu select
    zmodload zsh/complist
    compinit
    export KEYTIMEOUT=1
    
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
    
    source ~/.config/zsh/.p10k.zsh # p10k
    
    #termite name change to pwd    
    eval "$(direnv hook zsh)"
    case "$TERM" in
    vte*|xterm*|rxvt*)
        precmd() { print -Pn '\e];%n (%~) - Terminal\a' } ;;
    esac
    eval "$(direnv hook zsh)"
  '';
}; }
