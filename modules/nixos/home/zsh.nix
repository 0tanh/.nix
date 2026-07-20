{
  config,
  lib,
  pkgs,
  ...
}:
{
  # additional packages
  home.packages = with pkgs; [
    bat
    btop
    cbonsai
    cmatrix
    eza
    fd
    fzf
    nixfmt-tree
    pet
    pipes-rs
    procs
    repgrep
    ripgrep
    starship
    sudo
    tldr
    zoxide
  ];

  programs.zsh = {
    enable = true;
    dotDir = "/home/betty/.config/zsh";

    autocd = true;
    autosuggestion.enable = true;
    autosuggestion.highlight = "fg=#cdd6f4,bg=#313244";
    enableCompletion = true;
    defaultKeymap = "emacs";
    historySubstringSearch.enable = true;

    history = {
      expireDuplicatesFirst = true;
      path = "$ZDOTDIR/.zsh_history";
      append = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
      {
        name = "tinted-shell";
        file = "base16-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "tinted-theming";
          repo = "tinted-shell";
          rev = "main";
          hash = "sha256-Z+QUeeKZP7sDP0SGlBi7zdvjhIMJPCBBnPXeznMQpMQ=";

        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "darkblood";
      plugins = [
        "eza"
        "fzf"
        "gitfast"
        "ssh"
        "sudo"
        "zoxide"
        "ssh-agent"
      ];
      extraConfig = ''
        # disable save history by copy (cannot rename .zsh_history.new)
        unsetopt HIST_SAVE_BY_COPY

        # register ssh key in ssh-agent
        zstyle :omz:plugins:ssh-agent lazy yes
        zstyle :omz:plugins:ssh-agent identities ~/.ssh/uncia.id_ed25519

        zstyle ':completion:*:*:*:*:*' menu select

        # Complete . and .. special directories
        zstyle ':completion:*' special-dirs true

        zstyle ':completion:*' list-colors ""
        zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

        # disable named-directories autocompletion
        zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

        # Use caching so that commands like apt and dpkg complete are useable
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

        # Don't complete uninteresting users
        zstyle ':completion:*:*:*:users' ignored-patterns \
            adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
            clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
            gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
            ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
            named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
            operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
            rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
            usbmux uucp vcsa wwwrun xfs '_*'
        # ... unless we really want to.
        zstyle '*' single-ignored complete

        # https://thevaluable.dev/zsh-completion-guide-examples/
        zstyle ':completion:*' completer _extensions _complete _approximate
        zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
        zstyle ':completion:*' squeeze-slashes true
        zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

        # EZA plugin configuration
        # zstyle ':omz:plugins:eza' 'hyperlink' yes
        # zstyle ':omz:plugins:eza' 'size-prefix' binary
        # zstyle ':omz:plugins:eza' 'icons' yes
        # zstyle ':omz:plugins:eza' 'show-group' no
        # zstyle ':omz:plugins:eza' 'git-status' yes
        # zstyle ':omz:plugins:eza' 'dirs-first' yes


        zstyle ':omz:update' mode auto      # update automatically without asking
      '';
    };

    shellAliases = {
      "..." = "./..";
      "...." = "./../..";

      # rust rewrites
      cd = "z";
      cat = "bat";
      top = "btop";
      htop = "btop";
      grep = "rg";
      find = "fd";
      vim = "nvim";
      man = "tldr";
      tree = "broot";

      # replacements
      ls = "eza -lahsmod --group-directories-first --icons=auto";
      nano = "micro";

      # ripdrag
      drag = "${pkgs.dragon-drop}/bin/dragon-drop -a -x";

      # pet
      # saves cool snippets
      pets = "pet exec";
      petc = "pet clip";

      # nix
      n = "cd ~/.nix";
      # dot = "cd ~/.nix/res/sub/dotfiles/";
      rebuild = "cd ~/.nix && treefmt ~/.nix && ${pkgs.clean-problem-files}/bin/clean-problem-files && nh os switch '.?submodules=1'";
      update = "cd ~/.nix && treefmt ~/.nix && nix flake update secrets && nix flake update dotfiles && ${pkgs.clean-problem-files}/bin/clean-problem-files && nh os switch ~/.nix";
      drybuild = "cd ~/.nix && treefmt ~/.nix && ${pkgs.clean-problem-files}/bin/clean-problem-files && nh os boot ~/.nix";

      # git
      ga = "git add";
      gst = "git status";
      gdh = "git diff HEAD";
      gp = "git pull";
      gsp = "git submodule update --remote --recursive";
      gu = "git push";
      gc = "git commit";
      gco = "git checkout";
      lg = "lazygit";

      #fun
      pipes = "pipes-rs";
      matrix = "cmatrix -au2";
      bonsai = "cbonsai -lit0.05";

      # safety first...
      reboot = "${pkgs.confirm-reboot}/bin/confirm-reboot";
    };

    initContent = ''
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^e' end-of-line
      bindkey '^w' forward-word
      bindkey "^[[3~" delete-char
      bindkey ";5C" forward-word
      bindkey ";5D" backward-word

      # 10ms for key sequences
      KEYTIMEOUT=1

      # Uncomment the following line to use hyphen-insensitive completion.
      # Case-sensitive completion must be off. _ and - will be interchangeable.
      HYPHEN_INSENSITIVE="true"

      # Uncomment the following line to enable command auto-correction.
      ENABLE_CORRECTION="true"

      WORDCHARS='*?[]~=&;!#$%^(){}<>'

      # fixes duplication of commands when using tab-completion
      export LANG=C.UTF-8

      if [ "$TMUX" = "" ]; then tmux; fi

      ${pkgs.pokefetch}/bin/pokefetch
    '';
  };
}
