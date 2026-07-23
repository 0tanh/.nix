{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  all-configs = {
    modules = ../../../assets/submodule/dotfiles/quickshell/modules;
    overview = ../../../assets/submodule/dotfiles/quickshell/overview;
    services = ../../../assets/submodule/dotfiles/quickshell/services;
    main = ../../../assets/submodule/dotfiles/quickshell/main;
  };
  qs-path = {

  };
in
{
  # Configuration for writing a quickshell rice on nix
  # Link to ~/.config/quickshell/ from dotfiles/quickshell
  # xdg.configFile."quickshell".source = ../../../assets/submodule/dotfiles/quickshell;
  # QuickShell for things like sidebar.
  programs.quickshell = {
    enable = true;
    systemd = {
      enable = true; # if you prefer starting from your compositor
      target = "graphical-session.target";
    };
  };

  programs.zsh = {
    shellAliases = {
      # Shell shortcut to switch to a modifiable quickshell
      qs-dev = ''
        QUICKSHELL_REF_URL=https://quickshell.org/docs/v0.3.0/types/ 
        QUICKSHELL_TERMINAL=$'\e]8;;'"$QUICKSHELL_REF_URL"$'\e\\'"$QUICKSHELL_COPY"$'\e]8;;\e\\'

        DEV_DIR="$DOTFILES/dev"
        STARTER_SHELL="$DOTFILES/shell.qml"

        echo "Switching to Quickshell Dev"

        # Make dev folder if it doesn't exist (spaces required inside brackets)
        if [ ! -d "$DEV_DIR" ]; then
          # Changed from 'cat' to 'echo'
          echo "Quickshell dev folder not detected. Creating Dev Shell"
          mkdir -p "$DEV_DIR" 
        fi

        # Make a dev shell.qml 
        if [ ! -f "$DEV_DIR/shell.qml" ]; then
          echo "No shell found in $DEV_DIR. Creating new shell."
          
          if [ -f "$STARTER_SHELL" ]; then
            echo "Copying contents from starter"
            # cp is safer and cleaner than touch + cat
            cp "$STARTER_SHELL" "$DEV_DIR/shell.qml" 
          else
            # Create the file explicitly in the DEV_DIR
            touch "$DEV_DIR/shell.qml"
          fi
        fi

        echo "Activating Quickshell Dev Config"

        # -e flag allows echo to render the clickable terminal link
        echo -e "You can read more about quickshell in the $QUICKSHELL_TERMINAL"

        qs -c dev        
      '';
      # Shell shortcut to save the currently saved shortcut to ../../../../assets/submodule/dotfiles/quickshell/
      qs-save = ''

        # Function to save quickshell configs
        saveQuickshell() {
          # TODO THIS DOES NOT WORK
          save_location=$DOTFILES$1

          if [ ! -e "$save_location" ]; then 
            mkdir -p "$save_location"
          elif [ -d "$save_location" ]; then
            echo "Adding files to $save_location and updating existing files"
          fi 

          echo "Saving all files from $(pwd) to $save_location"
          cp -r . "$save_location"
        }

        if [[ $# -eq 0 ]]; then 
          while true; do
            read -p $'No config name specified. Would you like to save this config to the default directory?\n'"$DOTFILES [Y/n] " default_save
            
            if [[ $default_save == "y" || $default_save == "Y" || -z $default_save ]]; then 
              saveQuickshell ""
              echo "This configuration will be activated on next rebuild"
              break
            elif [[ $default_save == "n" || $default_save == "N" ]]; then
              read -p "What would you like to save this under? " config_name
              saveQuickshell "$config_name"
              echo FIXME
              echo "This configuration has been saved under $DOTFILES$config_name"
              break
            else
              echo "Please select either y or n"
            fi
          done
        else
          FIXME
          echo "This configuration has been saved under $DOTFILES$1"
          saveQuickshell "$1"
        fi

        echo "Config saved to dotfiles"

        pushd "$DOTFILES" > /dev/null
        git add .
        echo "New files are now tracked by git"

        while true; do 
          read -p "Would you like to commit these changes now? [y/N] " COMM
          if [[ $COMM == "y" || $COMM == "Y" ]]; then
            read -p "Commit message? " mess 
            git commit -m "$mess"
            echo "Committed all changes with commit message: $mess"
            break
          # Check for empty string (-z) here since default is No [y/N]
          elif [[ $COMM == "n" || $COMM == "N" || -z $COMM ]]; then 
            break
          else
            echo "Please select either y or n"
          fi
        done

        popd > /dev/null

      '';
    };
  };
}
