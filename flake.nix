{
  description = "Trying out nix; Attempting to package a jekyll site";
  inputs = {
      nixpkgs.url = "nixpkgs/";
  };
  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}
