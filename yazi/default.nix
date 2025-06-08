{ pluginInputs }:
{
  git = {
    src = pluginInputs.yazi_official_plugins_src + "/git.yazi";
  };

  miller = pluginInputs.yazi_plugin_miller_src;

  "full-border" = {
    src = pluginInputs.yazi_official_plugins_src + "/full-border.yazi";
  };

  yatline = pluginInputs.yazi_plugin_yatline_src;
}
