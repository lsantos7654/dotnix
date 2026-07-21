{ ... }:
let
  cfgFile = builtins.toFile "inputactions-config.yaml" ''
    touchpad:
      gestures:
        - type: swipe
          fingers: 3
          direction: down
          actions:
            - on: begin
              plasma_shortcut: kwin,Window Minimize

        - type: swipe
          fingers: 3
          direction: up
          actions:
            - on: begin
              plasma_shortcut: kwin,Overview

        - type: swipe
          fingers: 4
          direction: down
          actions:
            - on: begin
              plasma_shortcut: kwin,Window Close

        - type: swipe
          fingers: 3
          direction: left
          conditions: $window_class == kitty
          actions:
            - on: begin
              input:
                - keyboard: [ leftshift+leftmeta+h ]

        - type: swipe
          fingers: 3
          direction: right
          conditions: $window_class == kitty
          actions:
            - on: begin
              input:
                - keyboard: [ leftshift+leftmeta+l ]

        - type: swipe
          fingers: 3
          direction: left
          conditions: $window_class == firefox
          actions:
            - on: begin
              input:
                - keyboard: [ leftshift+leftmeta+l ]

        - type: swipe
          fingers: 3
          direction: right
          conditions: $window_class == firefox
          actions:
            - on: begin
              input:
                - keyboard: [ leftshift+leftmeta+h ]

        - type: swipe
          fingers: 3
          direction: left
          actions: []

        - type: swipe
          fingers: 3
          direction: right
          actions: []
  '';
in
{
  flake.modules.nixos.inputactions = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.kdePackages.inputactions-kwin ];

    users.users.inputactions = {
      isSystemUser = true;
      group = "inputactions";
    };
    users.groups.inputactions = { };
  };

  flake.modules.homeManager.inputactions = {
    xdg.configFile."inputactions/config.yaml".source = cfgFile;
  };
}