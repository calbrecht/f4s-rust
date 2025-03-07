{
  description = "Mozilla rust overlay flake";

  nixConfig = {
    flake-registry = "https://github.com/calbrecht/f4s-registry/raw/main/flake-registry.json";
  };

  inputs = {
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.nixpkgs-mozilla.overlays.rust
          self.overlay
        ];
      };
    in
    {
      defaultPackage."${system}" = pkgs.rust-stable;
      legacyPackages."${system}" = {
        rust-nightly = pkgs.rust-nightly;
        rust-src-nightly = pkgs.rust-src-nightly;
        rust-stable = pkgs.rust-stable;
        rust-src-stable = pkgs.rust-src-stable;
      };

      overlay = final: prev: {
        # https://rust-lang.github.io/rustup-components-history/
        rustNightly = (prev.rustNightly or { })
        // (prev.rustChannelOf or pkgs.rustChannelOf) {
          #sha256 = pkgs.lib.fakeSha256;
          #date = "";
          sha256 = "sha256-ESCt8uj5h9fvuQ7rK5AJqtsKskmYRufa3uPfcICcYdg=";
          date = "2023-02-04";
          #sha256 = "sha256-z+elrzVPDgtdqSMg8NTSGqkmfsK6vOn9XUFXcsSXhXo=";
          #date = "2022-04-07";
          #sha256 = "sha256-hZMoBt9dPsFEVzpOyLosxuAeA/KLfDPt0nwGQigwM9w=";
          #date = "2022-01-14";
          #sha256 = "sha256-O2UIx0rQIrFt3eg+1G0OmQWSJJ2cqRhSsmvEsSVeBMs=";
          #date = "2021-11-14";
          #sha256 = "sha256-k5/+9zafsA2ds0i2Nt7Oib7OBJihSVRoNe84LJkG/ic=";
          #date = "2021-10-14";
          #sha256 = "sha256-CU7J0ynkVTUuJ93IszuCHrDMaivAq3jZbDMfgjBLOBA=";
          #date = "2021-08-04";
          #sha256 = "sha256-9wp6afVeZqCOEgXxYQiryYeF07kW5IHh3fQaOKF2oRI=";
          #date = "2021-01-01";
          channel = "nightly";
          #sha256 = pkgs.lib.fakeSha256;
          #date = "2022-04-22";
          #channel = "stable";
        };

        rustStable = (prev.rustStable or { })
        // (prev.rustChannelOf or pkgs.rustChannelOf) {
          sha256 = "sha256-ks0nMEGGXKrHnfv4Fku+vhQ7gx76ruv6Ij4fKZR3l78="; #2023-07-27
          #sha256 = "sha256-gdYqng0y9iHYzYPAdkC/ka3DRny3La/S5G8ASj0Ayyc="; #2023-06-10
          #sha256 = "sha256-eMJethw5ZLrJHmoN2/l0bIyQjoTX1NsvalWSscTixpI="; #2023-04-29
          #sha256 = "sha256-4vetmUhTUsew5FODnjlnQYInzyLNyDwocGa4IvMk3DM="; #2023-03-13
          #sha256 = "sha256-JvgrOEGMM0N+6Vsws8nUq0W/PJPxkf5suZjgEtAzG6I="; #2023-03-13
          #sha256 = "sha256-S4dA7ne2IpFHG+EnjXfogmqwGyDFSRWFnJ8cy4KZr1k="; #2023-02-16
          #sha256 = "sha256-oro0HsosbLRAuZx68xd0zfgPl6efNj2AQruKRq3KA2g="; #2022-05-24
          #sha256 = "sha256-otgm+7nEl94JG/B+TYhWseZsHV1voGcBsW/lOD2/68g="; #2022-04-22
          channel = "stable";
        };

        rust-nightly = final.rustNightly.rust;
        rust-src-nightly = final.rustNightly.rust-src;

        rust-stable = final.rustStable.rust;
        rust-src-stable = final.rustStable.rust-src;
      };
    };
}
