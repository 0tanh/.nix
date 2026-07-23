
QUICKSHELL_REF_URL="https://quickshell.org/docs/v0.3.0/types/"
QUICKSHELL_TERMINAL=$'\e]8;;'"$QUICKSHELL_REF_URL"$'\e\\'"$QUICKSHELL_COPY"$'\e]8;;\e\\'

DEV_DIR="${DOTFILES}/dev"
STARTER_SHELL="${DOTFILES}/shell.qml"

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
  
  if [[ -f $STARTER_SHELL ]]; then
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
