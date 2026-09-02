{
  lib,
  stdenv,
  bash,
  coreutils,
  writeShellApplication,
}:
{
  # TODO use this at nix build time. for Whatever Reason Password isn't being properly evaluated
  writeShellApplication = {
    name = "feline-patup";
    /**
      runtimeInputs = with pkgs; [
        bash
        coreutils
      ];
    */
    text = ''
      if  [[-z ''${GIT_PASSWORD}" || -z ''${GIT_USER}"]] then
        echo "Setting git env variables..."
        export GIT_PASSWORD=$(cat /persist/home/betty/PAT.txt)
        export GIT_USER=0tanh;
      fi
    '';
  };
}
