{ inputs, pkgs, ... }:
{
  home.packages = with pkgs.jetbrains; [
    # Intellij IDEA for JVM work
    idea
    # cLion for working with a lot of C code
    clion
    # rust rover for working with a bunch of Rust code
    rust-rover
  ];
}
