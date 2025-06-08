{
  description = "Rhodium Alloys | Plugin Collections";

  inputs = {
    fish_plugin_colored_man_src = {
      url = "github:decors/fish-colored-man";
      flake = false;
    };

    fish_plugin_z_src = {
      url = "github:jethrokuan/z";
      flake = false;
    };

    yazi_official_plugins_src = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yazi_plugin_miller_src = {
      url = "github:Reledia/miller.yazi";
      flake = false;
    };
    yazi_plugin_yatline_src = {
      url = "github:imsi32/yatline.yazi";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs_map:
    let
      mkPluginSet = pluginDefinitions:
        let
          plugins = builtins.mapAttrs (name: definition: {
            inherit name;
            src = if builtins.isString definition then definition else definition.src;
          }) pluginDefinitions;
        in
        {
          inherit plugins;
          pluginsList = builtins.attrValues plugins;
        };

      fishPluginDefinitions = import ./fish { pluginInputs = inputs_map; };
      yaziPluginDefinitions = import ./yazi { pluginInputs = inputs_map; };

    in
    {
      fish = mkPluginSet fishPluginDefinitions;
      yazi = mkPluginSet yaziPluginDefinitions;

      legacyPackages.x86_64-linux.fishPlugins = self.fish.plugins;
      legacyPackages.x86_64-linux.fishPluginsList = self.fish.pluginsList;
      legacyPackages.x86_64-linux.yaziPlugins = self.yazi.plugins;
      legacyPackages.x86_64-linux.yaziPluginsList = self.yazi.pluginsList;
    };
}
