{
  description = "Rhodium Alloys | Plugin Collections";

  inputs = {
    fish-colored-man = { url = "github:decors/fish-colored-man"; flake = false; };
    fish-z = { url = "github:jethrokuan/z"; flake = false; };
    yazi-official = { url = "github:yazi-rs/plugins"; flake = false; };
    yazi-miller = { url = "github:Reledia/miller.yazi"; flake = false; };
    yazi-yatline = { url = "github:imsi32/yatline.yazi"; flake = false; };
  };

  outputs = { self, ... }@inputs: {
    fish = [
      { name = "colored-man"; src = inputs.fish-colored-man; }
      { name = "z"; src = inputs.fish-z; }
    ];

    yazi = {
      git = inputs.yazi-official + "/git.yazi";
      miller = inputs.yazi-miller;
      full-border = inputs.yazi-official + "/full-border.yazi";
      yatline = inputs.yazi-yatline;
    };
  };
}
