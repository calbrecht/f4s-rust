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
        overlays = [ self.overlay ];
      };
    in
    {
      defaultPackage."${system}" = pkgs.rustNightly.rust;

      overlay = final: prev: {
        nixpkgs-mozilla = (prev.nixpkgs-mozilla or { }) //
        (import inputs.nixpkgs-mozilla final prev);

        # https://rust-lang.github.io/rustup-components-history/
        rustNightly = (prev.rustNightly or { }) //
        (import inputs.nixpkgs-mozilla final prev).rustChannelOf {
          #sha256 = "sha256-9wp6afVeZqCOEgXxYQiryYeF07kW5IHh3fQaOKF2oRI=";
          sha256 = "sha256-CU7J0ynkVTUuJ93IszuCHrDMaivAq3jZbDMfgjBLOBA=";
          date = "2021-08-04";
          #date = "2021-01-01";
          channel = "nightly";
          #sha256 = "sha256-0BuV+blSz4OrplGvWKmeTq6fDlFPLJ3rZWkO5+HSAHM=";
          #date = "2020-10-17";
        };
      };
    };
}
