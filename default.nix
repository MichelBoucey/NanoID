let
 pkgs = import <nixpkgs> { };
in
 { ip6addr = pkgs.haskellPackages.callPackage ./nanoid.nix { }; }
