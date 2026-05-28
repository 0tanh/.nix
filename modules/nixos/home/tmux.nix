{
  pkgs,
  lib,
  ...
}:
let
  tmuxPlugins = with pkgs.tmuxPlugins; [
    better-mouse-mode
    fuzzback
    open
    tmux-floax
    tmux-thumbs
  ];
in
{
  programs.tmux = {
    enable = true;

    shell = "${pkgs.zsh}/bin/zsh";
    baseIndex = 1;
    prefix = "C-Space";
    historyLimit = 10000;
    mouse = true;

    plugins = tmuxPlugins;
    extraConfig = ''
      	# https://unix.stackexchange.com/questions/23138/esc-key-causes-a-small-delay-in-terminal-due-to-its-alt-behavior
        set -s escape-time 0

        # tmux plugin manager
        # set -g @plugin 'tmux-plugins/tpm'

        # tmux-thumbs copy
        set -g @thumbs-command 'echo -n {} | wl-copy'

        # fast-reload tmux config
        bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."

        # xterm support
        set -g default-terminal "tmux-256color"
        set -g xterm-keys on

        # better panes
        unbind-key \"
        unbind-key %
        bind-key | split-window -h
        bind-key _ split-window -v

        # kill window
        unbind-key d
        unbind-key `

        # floax
        set -g @floax-bind 'p'

        # new window
        unbind-key c
        bind-key Enter new-window

        # rename window
        unbind-key ,
        bind-key \\ command-prompt -I "#W" "rename-window '%%'"

        # choose window
        unbind-key w
        bind-key Tab choose-window

        # close pane (confirm or not)
        unbind-key &
        unbind-key x
        bind-key Bspace kill-pane

        # previous and next window
        # unbind-key p
        unbind-key n
        bind-key [ previous-window
        bind-key ] next-window

        # statusbar
        set -g status-position top
        set -g status-justify left
    '';
  };
}
