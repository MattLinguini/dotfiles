{ lib, config, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf mkMerge types;
  inherit (lib.matt) mkOpt;
in
{
  options.mine.users = mkOption {
    type = types.attrsOf (types.submodule ({ name, ... }: {
      options = {
        enable = mkEnableOption "Enable user ${name}";
        alias = mkOpt types.str name "Full alias";
        email = mkOpt types.str "" "User email";
        homeDir = mkOpt types.str "/home/${name}" "Home directory path";
        home-manager.enable = mkOpt types.bool false "Enable home-manager";
        ghToken.enable = mkEnableOption "Include GitHub access-tokens in nix.conf";
        shell = mkOption {
          default = { };
          description = "Shell config for user";
          type = types.submodule {
            options = {
              package = mkOpt types.package pkgs.fish "Shell package";
            };
          };
        };
      };
    }));
    default = {};
    description = "Map of user configs";
  };

  config = mkMerge (
    lib.attrValues (lib.mapAttrs (name: user:
      mkIf user.enable {
        mine.system.shell.zsh.enable = mkIf (user.shell.package == pkgs.zsh) true;

        nix.settings.trusted-users = [ name ];

        environment.variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };

        users.groups.${name} = { };
        users.users.${name} = {
          isNormalUser = true;
          createHome = true;
          group = name;
          extraGroups = [ "wheel" ];
          shell = user.shell.package;
        };

        home-manager.users.${name} = mkIf user.home-manager.enable {
          home.username = name;
          home.homeDirectory = user.homeDir;
          programs.fish.enable = user.shell.package == pkgs.fish;
          programs.zsh.enable = user.shell.package == pkgs.zsh;
          home.stateVersion = "24.11";
          home.sessionVariables = {
            EDITOR = "nvim";
            VISUAL = "nvim";
          };
        };
      }
    ) config.mine.users)
  );
}
