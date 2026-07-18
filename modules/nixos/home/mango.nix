{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
in
{
  imports = [
    inputs.mango.hmModules.mango
  ];

  # additional packages
  home.packages = with pkgs; [
    # screenshots
    grim # captures region of screen
    slurp # screen region selector
    swappy # simple image editor
    fuzzel

    wlr-randr # monitor information
    wl-clipboard # wayland clipboard

    libnotify # desktop notifications
    wf-recorder # screen recorder
    # screen recording script
    (pkgs.writeShellScriptBin "screen-record" ''
      pgrep -x "wf-recorder" && pkill -INT -x wf-recorder && notify-send -h string:wf-recorder:record -t 1000 "Finished Recording" && exit 0
      #notify-send -h string:wf-recorder:record -t 1000 "Recording in:" "<span color='#90a4f4' font='26px'><i><b>3</b></i></span>"; sleep 1
      #notify-send -h string:wf-recorder:record -t 1000 "Recording in:" "<span color='#90a4f4' font='26px'><i><b>2</b></i></span>"; sleep 1
      #notify-send -h string:wf-recorder:record -t 950 "Recording in:" "<span color='#90a4f4' font='26px'><i><b>1</b></i></span>"; sleep 1
      dateTime=$(date +%m-%d-%Y-%H:%M:%S)
      wf-recorder --audio-backend=pipewire -a --bframes max_b_frames -c h264_vaapi -d /dev/dri/renderD128 -g "$(slurp)" -f $HOME/rec_$dateTime.mp4
    '')

    # pkgs.hyprlock
    # hyprpicker # color picker

    networkmanagerapplet

    yazi
    kitty
  ];

  # screenshot image editor config
  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=$HOME/Desktop
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=sans-serif
    paint_mode=brush
    early_exit=false
    fill_shape=false
  '';

  wayland.windowManager.mango = {
    enable = true;
    systemd.enable = true;
    settings = ''
      ################
      # mango config #
      ################

      # autostart
      # xwayland on xdg dbus activation
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

      # set up wallpaper
      # exec-once=${pkgs.swaybg}/bin/swaybg -i ~/.nix/res/img/stairs-green.jpg

      # start the desktop shell
      # exec-once=${inputs.caelestia-shell.packages."x86_64-linux".default}/bin/caelestia-shell

      # trap applets
      exec-once=nm-applet
      exec-once=blueman-applet

      # spawn terminal
      exec-once=kitty

      # spawn apps
      # exec-once=zen
      # exec-once=spotify

      ###############
      # keybindings #
      ###############
      bind=SUPER,Q,killclient
      bind=SUPER,C,spawn,kitty
      bind=SUPER,F,spawn,kitty yazi
      bind=SUPER,F,spawn,kitty nvim
      bind=SUPER,space,spawn,fuzzel
      bind=SUPER,V,togglefloating
      bind=SUPER,S,spawn_shell,grim -g "$(slurp -w 0)" - | wl-copy
      bind=SUPER+SHIFT,S,spawn_shell,grim -g "$(slurp -w 0)" - | swappy -f -
      bind=SUPER+CTRL,S,spawn_shell,screen-record
      bind=SUPER+CTRL+SHIFT,Q,quit

      # macros
      bind=SUPER+CTRL+ALT+SHIFT,1,spawn,kitty rip url "$(wl-paste)"
      bind=SUPER+CTRL+ALT+SHIFT,2,spawn,kitty rip search deezer track "$(wl-paste)"

      # change focus
      bind=SUPER,Left,focusdir,left
      bind=SUPER,Right,focusdir,right
      bind=SUPER,Up,focusdir,up
      bind=SUPER,Down,focusdir,down

      # switch workspace: mod + [0-9]
      bind=SUPER,1,view,1
      bind=SUPER,2,view,2
      bind=SUPER,3,view,3
      bind=SUPER,4,view,4
      bind=SUPER,5,view,5
      bind=SUPER,6,view,6
      bind=SUPER,7,view,7
      bind=SUPER,8,view,8
      bind=SUPER,9,view,9

      # move active window to workspace: mod + SHIFT + [0-9]
      bind=SUPER+SHIFT,1,tag,1
      bind=SUPER+SHIFT,2,tag,2
      bind=SUPER+SHIFT,3,tag,3
      bind=SUPER+SHIFT,4,tag,4
      bind=SUPER+SHIFT,5,tag,5
      bind=SUPER+SHIFT,6,tag,6
      bind=SUPER+SHIFT,7,tag,7
      bind=SUPER+SHIFT,8,tag,8
      bind=SUPER+SHIFT,9,tag,9

      # alt tab
      bind=ALT,Tab,focuslast

      # move window: mod + SHIFT + arrowkey
      bind=SUPER+SHIFT,Left,exchange_client,left
      bind=SUPER+SHIFT,Right,exchange_client,right
      bind=SUPER+SHIFT,Up,exchange_client,up
      bind=SUPER+SHIFT,Down,exchange_client,down

      # mouse move
      # Move window with Super + Left Click
      mousebind=SUPER,btn_left,moveresize,curmove
      # Resize window with Super + Right Click
      mousebind=SUPER,btn_right,moveresize,curresize

      # layout management
      bind=SUPER,Return,switch_layout

      ##################
      # monitor config #
      ##################
      # https://mangowc.vercel.app/docs/configuration/monitors
      # monitorrule=name,mfact,nmaster,layout,transform,scale,x,y,width,height,refreshrate
      monitorrule=name:^eDP-1$,scale:1,x:0,y:0,width:1440,height:900,refresh:60

      # input
      repeat_rate=20
      repeat_delay=200
      numlockon=1
      xkb_rules_layout=us
      # xkb_rules_options=caps:escape

      # misc configuration
      focus_cross_monitor=1
      focus_on_activate=0
      cursor_hide_timeout=60
      # cursor_theme
      allow_lock_transparent=1
      exchange_cross_monitor=1

      # overview
      enable_hotarea=0
      hotarea_corner=0
      hotarea_size=0
      ov_no_resize=1

      # visual settings
      borderpx=2
      gappih=2
      gappiv=2
      gappoh=5
      gappov=5

      # https://coolors.co/ for picking color palettes
      # theme

      # Background color of the root window
      rootcolor=0x203b14ff        
      bordercolor=0x50608066
      focuscolor=0xA0B0D0ff
      # Urgent window border (alerts)
      urgentcolor=0xad401fff      

      # maximizescreencolor=0x89aa61ff # Maximized
      # scratchpadcolor=0x516c93ff # Scratchpad
      # Global
      globalcolor=0xb153a7ff 
      # Overlay
      overlaycolor=0x14a57cff 

      # scratchpad_width_ratio=0.8
      # scratchpad_height_ratio=0.9

      ##################
      # VISUAL EFFECTS #
      ##################
      blur=1
      border_radius=4
      focused_opacity=0.95
      unfocused_opacity=0.55
      no_radius_when_single=1

      # animations
      animation_type_open=zoom
      animation_type_close=fade
      fadein_begin_opacity=0
      fadeout_begin_opacity=1
      zoom_initial_ratio=0
      zoom_end_ratio=1

      # animation timings
      animation_duration_move=350
      animation_duration_open=250
      animation_duration_tag=200
      animation_duration_close=150
      animation_duration_focus=50

      # animation curves
      animation_curve_open=0.16,1.0,0.3,1.0
      animation_curve_move=0.16,1.0,0.3,1.0
      animation_curve_tag=0.65,0.0,0.35,1.0
      animation_curve_close=0.46,1.0,0.29,0.99
      animation_curve_focus=0.46,1.0,0.29,0.99
      animation_curve_opafadein=0.46,1.0,0.29,0.99
      animation_curve_opafadeout=0.5,0.5,0.5,0.5


      ################
      # window rules #
      ################
      # windowrule=Parameter:Value,Parameter:Value,appid:Regex,title:Regex
      # windowrule=appid:kitty,isfloating:1,width:2308,height:1923,tags:2,monitor:DP-3,isterm:1
      # windowrule=appid:firefox,tags:1,monitor:DP-3,isopensilent:1
      # windowrule=appid:vesktop,tags:1,monitor:HDMI-A-1
      # windowrule=appid:org.telegram.desktop,tags:1,monitor:HDMI-A-1,isopensilent:1
      # windowrule=appid:.blueman-manager-wrapped,isfloating:1
      # windowrule=appid:org.qbittorrent.qBittorrent,tags:4,monitor:DP-3
      # windowrule=appid:1Password,tags:3,monitor:DP-3,isfloating:1,width:800,height:800,offsetx:0,offsety:0
      # windowrule=title:fern|moss,isfloating:1,width:640,height:480,offsetx:0,offsety:0
      # windowrule=appid:qemu-system-x86_64,tags:3,monitor:DP-3
    '';
    autostart_sh = ''
      # disable DP-1 port (active despite no device present)
      # mmsg -d disable_monitor,DP-1
    '';
  };

  # additional configuration
}
