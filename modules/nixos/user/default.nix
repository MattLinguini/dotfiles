{ lib, config, pkgs, inputs, ...}:

with lib;

let
  inherit (lib.matt) mkOpt;
  inherit (config.mine) user;
  home-directory = "/home/${user.name}";
in {
  options.mine.user = {
    enable = mkEnableOption "Enable User";
    name = mkOpt types.str "matt" "User account name";
    alias = mkOpt types.str "mattbennett" "Full alias";
    email = mkOpt types.str "matt.bennett715@@gmail.com" "My Email";
    homeDir = mkOpt types.str "${home-directory}" "Home Directory Path";
    home-manager.enable = mkOpt types.bool false "Enable home-manager";
    ghToken.enable = mkEnableOption "Include GitHub access-tokens in nix.conf";
    shell = mkOption {
      default = { };
      description = "Shell config for user";
      type = types.submodule {
        options = {
          package = mkOpt types.package pkgs.fish "User shell";
          starship.enable = mkOpt types.bool true "Enable starship";
        };
      };
    };
  };

  config = mkIf user.enable {

    nix.settings.trusted-users = [ "${user.name}" ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    users.groups.${user.name} = { };

    users.users.${user.name} = {
      isNormalUser = true;
      createHome = true;
      group = "${user.name}";
      extraGroups = [ "wheel" ];
    };

  };
}