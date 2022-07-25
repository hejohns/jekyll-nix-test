{
  description = "Let's do this tweag hello world";
  nixConfig.bash-prompt = "nix-dev: \\w\\$ ";
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs {inherit system;};
      rec {
        packages = flake-utils.lib.flattenTree {
          hello = nixpkgs.legacyPackages.${system}.hello;
          ruby = nixpkgs.legacyPackages.${system}.ruby_3_1;
          foobar = stdenv.mkDerivation {
            pname = "foobar";
            version = "0.0.0";
            src = self;
            buildInputs = [nixpkgs.legacyPackages.${system}.ruby];
            buildPhase = ''
              rake
            '';
          };
        };
        defaultPackage = packages.hello;
        apps.hello = flake-utils.lib.mkApp {drv = packages.ruby;};
        defaultApp = apps.hello;
      }
    );

#flake-utils.lib.simpleFlake {
#  inherit self nixpkgs;
#  name = "my-proj";
#};
#outputs.defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
# packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
# defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
}
