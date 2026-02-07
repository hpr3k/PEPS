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
      	python-lsp-server
        numpy
        torch-bin
        numba
        cupy
        matplotlib
        ipympl
        ipykernel
        jupyterlab
        jupyterlab-lsp
        jupyterlab-git
        jupyter-themes
        jupyterlab-widgets
        jupyterlab-execute-time
        pandas
      ]);
    runtimeLibs = with pkgs; [
            stdenv.cc.cc.lib
            dbus
            zlib
            glib
            libGL
            libGLU
            vulkan-loader
            ffmpeg-full
            libpng
            libjpeg
            libtiff
            libwebp
            portaudio
            libsndfile
            alsa-lib  
            hdf5
            openssl
            curl
            fontconfig
            freetype
            expat
            libffi
            libusb1
            libv4l
            xorg.libX11
            xorg.libXext
            xorg.libXrender
            libxkbcommon
            gfortran.cc.lib
          ];
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pythonEnv ];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (runtimeLibs);
      };
    };
}
