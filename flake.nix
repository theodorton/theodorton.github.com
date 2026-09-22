{
  description = "theodorton.github.io — a Hugo blog";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-parts.url = "github:hercules-ci/flake-parts";
    # Pinned-version package set, so we can get a Hugo old enough for this site.
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

      perSystem = {
        pkgs,
        system,
        mv,
        ...
      }: let
        hugo = mv.versions.hugo."0.60.0";
        hugo-natrium-theme = pkgs.fetchFromGitHub {
          owner = "mobybit";
          repo = "hugo-natrium-theme";
          rev = "e2145b8d57ac3a0368860b6d9d708c5fb036a582";
          hash = "sha256-Ns7yLitRLL2/3K+oTYRZoyBSeN6Tb473LRutt0++qeU=";
        };
        themesDir = pkgs.linkFarm "hugo-themes" [
          {
            name = "hugo-natrium-theme";
            path = hugo-natrium-theme;
          }
        ];
      in {
        _module.args.mv = inputs.multiverse.legacyPackages.${system};

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "blog";
          version = "0.0.1";
          src = pkgs.lib.cleanSource ./.;
          nativeBuildInputs = [hugo];
          buildPhase = ''
            hugo --themesDir ${themesDir} -d $out
          '';
          dontInstall = true;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            # Upgrading stepwise from 0.57.2. Known remaining deprecations:
            # .Hugo.Generator (use hugo.Generator), .URL (use .RelPermalink),
            # .RSSLink (use OutputFormats). Hugo 0.60 switches to Goldmark.
            hugo
            pkgs.git
          ];
          HUGO_THEMESDIR = "${themesDir}";
        };
      };
    };
}
