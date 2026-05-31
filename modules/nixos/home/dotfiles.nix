{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  # dotfiles = builtins.toString inputs.dotfiles;
in
{
  # INFO: statically linked dotfiles, readonly and cannot be edited
  # more strict, but more correct -- use this when you aren't modifying config often
  # xdg.configFile = lib.mergeAttrsList (
  # 	map (module: {
  # 		"${module}".source = lib.helpers.mkOutOfStoreSymlink "${dotfiles}/${module}";
  # 	}) [ "nvim" ]
  # );

  # INFO: dynamically linke dotfiles, editable but volatile
  # less strict, allows fast changes, but can be easily overwritten or deleted
  home.activation = lib.mergeAttrsList (
    map
      (module: {
        "direct-link-${module}" = inputs.home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ] (''
          rm -rf /home/betty/.config/${module}
          $DRY_RUN_CMD ln -sfvn /home/betty/.nix/assets/submodule/dotfiles/${module} /home/betty/.config/${module}
        '');
      })
      [
        "nvim"
      ]
  );

}
