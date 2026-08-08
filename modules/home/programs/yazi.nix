{inputs, ...}: {
  imports = [inputs.fuzzy-search-yazi.homeManagerModules.default];
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    yaziPlugins = {
      plugins = {
        fuzzy-search = {
          enable = true; # enables the plugin
          enableFishIntegration = true; # Enables the Fish function for Zoxide Shift + Z
          depth = 3; # eza tree depth control default is =TL=3
          keymaps = {
            # sets default keybinds see below
            fd = true;
            rg = true;
            zoxide = true;
          };
        };
      };
    };
  };
}
