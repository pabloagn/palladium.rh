{
  description = "Rhodium Alloys | Plugin Collections";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fish-colored-man = {
      url = "github:decors/fish-colored-man";
      flake = false;
    };
    fish-z = {
      url = "github:jethrokuan/z";
      flake = false;
    };
    yazi-official = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yazi-miller = {
      url = "github:Reledia/miller.yazi";
      flake = false;
    };
    yazi-yatline = {
      url = "github:imsi32/yatline.yazi";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    fish = [
      {
        name = "colored-man";
        src = inputs.fish-colored-man;
      }
      {
        name = "z";
        src = inputs.fish-z;
      }
    ];
    yazi = {
      git = inputs.yazi-official + "/git.yazi";
      miller = inputs.yazi-miller;
      full-border = inputs.yazi-official + "/full-border.yazi";
      yatline = inputs.yazi-yatline;
    };

    # Development shell
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        # Nix tools
        nixpkgs-fmt
        nil
        nix-tree

        # Development utilities
        git
        curl
        jq

        # Plugin testing tools
        fish
        yazi
      ];

      shellHook = ''
        echo "Rhodium Alloys Dev Environment"
        echo "Plugin collections ready for development"
        echo ""
        echo "Available tools:"
        echo "  - nixpkgs-fmt: Format Nix files"
        echo "  - nil: Nix language server"
        echo "  - nix-tree: Explore dependency tree"
        echo "  - fish/yazi: Test plugins"
        echo ""
      '';
    };
  };
}
