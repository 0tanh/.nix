DOTFILES="$HOME/.nix/assets/submodule/dotfiles/quickshell/"

# Function to save quickshell configs
saveQuickshell() {
  local save_location="${DOTFILES}${1}"

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
    # Use $'...' to evaluate the \n newline character in the prompt
    read -p -r $'No config name specified. Would you like to save this config to the default directory?\n'"$DOTFILES [Y/n] " default_save
    
    if [[ $default_save == "y" || $default_save == "Y" || -z $default_save ]]; then 
      saveQuickshell ""
      echo "This configuration will be activated on next rebuild"
      break
    elif [[ $default_save == "n" || $default_save == "N" ]]; then
      read -p -r "What would you like to save this under? " config_name
      saveQuickshell "$config_name"
      echo "This configuration has been saved under ${DOTFILES}${config_name}"
      break
    else
      echo "Please select either y or n"
    fi
  done
else
  echo "This configuration has been saved under ${DOTFILES}${1}"
  saveQuickshell "$1"
fi

echo "Config saved to dotfiles"

# pushd/popd is safer than cd for returning to the previous directory
pushd "$DOTFILES" || exit  > /dev/null
git add .
echo "New files are now tracked by git"

while true; do 
  read -p -r "Would you like to commit these changes now? [y/N] " COMM
  if [[ $COMM == "y" || $COMM == "Y" ]]; then
    read -p -r "Commit message? " mess 
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

popd || exit> /dev/null
