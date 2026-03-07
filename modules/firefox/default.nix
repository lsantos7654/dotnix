{ ... }:
{
  flake.modules.homeManager.firefox = { pkgs, ... }:
  let
    firefox-mod-blur = pkgs.fetchFromGitHub {
      owner = "datguypiko";
      repo = "Firefox-Mod-Blur";
      rev = "0c510480ad381fc2eb549e8e5aeee23c4fd31131";
      hash = "sha256-0t5iHuqHX27TMxyHXosZ4NtBQkyFomB8IlRQcM+xeT0=";
    };

    firefoxChrome = pkgs.runCommandLocal "firefox-mod-blur-chrome" {} ''
      mkdir -p $out/image

      # Images: upstream ASSETS/icons + ASSETS/other → image/
      cp --no-preserve=mode ${firefox-mod-blur}/ASSETS/icons/* $out/image/
      cp --no-preserve=mode ${firefox-mod-blur}/ASSETS/other/* $out/image/ 2>/dev/null || true

      # Flatten all upstream CSS mods into chrome root (--no-preserve=mode so files stay writable,
      # -n to skip duplicates across subdirectories)
      find "${firefox-mod-blur}/EXTRA MODS" -name "*.css" -exec cp -n --no-preserve=mode {} $out/ \;
      find "${firefox-mod-blur}/EXTRA THEMES" -name "*.css" -exec cp -n --no-preserve=mode {} $out/ \;

      # User's custom CSS files (override any upstream equivalents)
      cp --no-preserve=mode ${./userChrome.css} $out/userChrome.css
      cp --no-preserve=mode ${./userContent.css} $out/userContent.css
      cp --no-preserve=mode ${./bookmarks_bar_same_color_as_toolbar.css} $out/bookmarks_bar_same_color_as_toolbar.css
      cp --no-preserve=mode ${./cleaner_extensions_menu.css} $out/cleaner_extensions_menu.css
    '';
  in
  {
    programs.firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        isDefault = true;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "full-screen-api.ignore-widgets" = true;
        };
      };
    };

    home.file.".mozilla/firefox/default/chrome" = {
      source = firefoxChrome;
      recursive = true;
    };
  };
}
