# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pythonEnv = pkgs.python313.withPackages (p: with p; [
        numpy
        torch-bin
        numba
        cupy
        matplotlib
        ipympl
        jupyterlab
        jupyterlab-lsp
        jupyterlab-git
        jupyter-themes
        jupyterlab-widgets
        jupyterlab-execute-time
        pandas
      ]);
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pythonEnv ];
      };
    };
}
