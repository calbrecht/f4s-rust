{
  description = "Mozilla rust overlay flake";

  inputs = {
    nixpkgs-mozilla = {
      url = github:mozilla/nixpkgs-mozilla;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (import inputs.nixpkgs-mozilla)
          self.overlay
        ];
      };
    in
    {
      defaultPackage."${system}" = pkgs.rust-nightly;

      overlay = final: prev: {
        # https://rust-lang.github.io/rustup-components-history/
        rustNightly = (prev.rustNightly or { })
        // (prev.rustChannelOf or pkgs.rustChannelOf) {
          #sha256 = pkgs.lib.fakeSha256;
          #date = "";
          sha256 = "sha256-O2UIx0rQIrFt3eg+1G0OmQWSJJ2cqRhSsmvEsSVeBMs=";
          date = "2021-11-14";
          #sha256 = "sha256-k5/+9zafsA2ds0i2Nt7Oib7OBJihSVRoNe84LJkG/ic=";
          #date = "2021-10-14";
          #sha256 = "sha256-CU7J0ynkVTUuJ93IszuCHrDMaivAq3jZbDMfgjBLOBA=";
          #date = "2021-08-04";
          #sha256 = "sha256-9wp6afVeZqCOEgXxYQiryYeF07kW5IHh3fQaOKF2oRI=";
          #date = "2021-01-01";
          channel = "nightly";
        };

        rust-nightly = final.rustNightly.rust;
        rust-src-nightly = final.rustNightly.rust-src;
      };
    };
}
