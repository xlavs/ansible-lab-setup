# config/nix/shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    coreutils gnugrep gawk findutils jq file tree wget unzip zip
    iputils dig
    vim-full emacs-nox git
    ansible
  ];
}
