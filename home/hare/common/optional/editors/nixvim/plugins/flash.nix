{ ... }:
{
  programs.nixvim.keymaps = [
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = "<cmd>lua require(\"flash\").jump()<cr>";
    }
    # {
    #   key = "S";
    #   mode = [
    #     "n"
    #     "x"
    #     "o"
    #   ];
    #   action = "<cmd>lua require(\"flash\").treesitter()<cr>";
    # }
    # {
    #   key = "r";
    #   mode = [
    #     "o"
    #   ];
    #   action = "<cmd>lua require(\"flash\").remote()<cr>";
    # }
    # {
    #   key = "R";
    #   mode = [
    #     "x"
    #     "o"
    #   ];
    #   action = "<cmd>lua require(\"flash\").treesitter_search()<cr>";
    # }
    # {
    #   key = "<C-s>";
    #   mode = [
    #     "c"
    #   ];
    #   action = "<cmd>lua require(\"flash\").toggle()<cr>";
    # }
    # {
    #   key = "<c-space>";
    #   mode = [
    #     "n"
    #     "x"
    #     "o"
    #   ];
    #   action = lib.nixvim.mkRaw ''
    #     function()
    #       require("flash").treesitter({
    #         actions = {
    #           ["c-space"] = "next",
    #           ["<BS>"] = "prev"
    #         }
    #       })
    #     end,
    #   '';
    # }
  ];

  programs.nixvim.plugins.flash = {
    enable = true;
    settings.modes.char.jump_labels = true;
  };
}
