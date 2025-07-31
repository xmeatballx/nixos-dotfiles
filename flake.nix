{
  description = "my NixOS config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ...}:
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
       modules = [ stylix.nixosModules.stylix ./system/laptop-configuration.nix ];
     };
     nixos-dev = lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ ./system/devbox-configuration.nix ];
     };
    };
    homeConfigurations = {
      meatball = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ stylix.homeManagerModules.stylix ./user/home.nix ];
      };
      dev = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ ./user/dev.nix ];
      };
    };
  };
}
