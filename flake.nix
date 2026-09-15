{
  description = "theodorton.github.io — a Hugo blog";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    # Pinned-version package set, so we can get a Hugo old enough for this site.
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
  };

  outputs = inputs: {
    devShells = builtins.mapAttrs (system: pkgs: let
      hugo-natrium-theme = pkgs.fetchFromGitHub {
        owner = "mobybit";
        repo = "hugo-natrium-theme";
        rev = "e2145b8d57ac3a0368860b6d9d708c5fb036a582";
        hash = "sha256-Ns7yLitRLL2/3K+oTYRZoyBSeN6Tb473LRutt0++qeU=";
      };
      themesDir = pkgs.linkFarm "hugo-themes" [
        { name = "hugo-natrium-theme"; path = hugo-natrium-theme; }
      ];
    in {
      default = pkgs.mkShell {
        packages = [
          # The published site is built with Hugo 0.40.x (see the generator meta
          # tag on theodorton.github.io), and 0.40.3 reproduces it byte for byte.
          # Hugo 0.60 switched to the Goldmark markdown renderer, which changes
          # heading anchor ids, and 0.93 dropped the theme's `.Hugo.Generator`.
          inputs.multiverse.legacyPackages.${system}.versions.hugo."0.40.3"
          pkgs.git
        ];
        HUGO_THEMESDIR = "${themesDir}";
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
