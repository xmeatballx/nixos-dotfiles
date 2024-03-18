{
  description = "my first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...}:
  let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in  {
    nixosConfigurations = {
      nixos-main = lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./system/configuration.nix ];
    };
     nixos-laptop = lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ ./system/laptop-configuration.nix ];
     };
    };
    homeConfigurations = {
      meatball = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ ./user/home.nix ];
      };
    };
  };
}
