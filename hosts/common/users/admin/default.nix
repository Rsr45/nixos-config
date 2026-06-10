{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  hostSpec = config.hostSpec;
  # pubKeys = lib.filesystem.listFilesRecursive ./keys;
in
{
  users.users.${hostSpec.adminUserName} = {
    name = hostSpec.adminUserName;
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    rsync
  ];
}

# Import the user's personal/home configurations, unless the environment is minimal
# // lib.optionalAttrs (inputs ? "home-manager") {
#   home-manager = {
#     extraSpecialArgs = {
#       inherit pkgs inputs;
#       hostSpec = config.hostSpec;
#     };
#     users.${hostSpec.username}.imports = lib.flatten (
#       lib.optional (!hostSpec.isMinimal) [
#         (
#           { config, ... }:
#           import (lib.custom.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}.nix") {
#             inherit
#               pkgs
#               inputs
#               config
#               lib
#               hostSpec
#               ;
#           }
#         )
#       ]
#     );
#   };
# }
