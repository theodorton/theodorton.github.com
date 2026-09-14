{
  description = "theodorton.github.io — a Hugo blog";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    # Pinned-version package set, so we can get a Hugo old enough for this site.
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
  };

  outputs = inputs: {
    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        packages = [
          # The published site is built with Hugo 0.40.x (see the generator meta
          # tag on theodorton.github.io), and 0.40.3 reproduces it byte for byte.
          # Hugo 0.60 switched to the Goldmark markdown renderer, which changes
          # heading anchor ids, and 0.93 dropped the theme's `.Hugo.Generator`.
          inputs.multiverse.legacyPackages.${system}.versions.hugo."0.40.3"
          pkgs.git
        ];
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
