{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.keymaps = [
    {
      key = "<leader>ct";
      mode = [ "n" ];
      action = "<cmd>lua MiniTrailspace.trim()<CR>";
      options.desc = "Trim";
    }
    {
      key = "<leader>cT";
      mode = [ "n" ];
      action = "<cmd>lua MiniTrailspace.trim()<CR>";
      options.desc = "Trim end";
    }
    {
      key = "<leader>bd";
      mode = "n";
      action = "<cmd>lua MiniBufremove.delete()<CR>";
      options.desc = "Delete Buffer";
    }
  ];

  programs.nixvim.plugins = {
    mini.enable = true;
    mini.modules = {
      ## Text editing
      ai = { };
      align = { };
      comment = { };
      # completion = { };
      keymap = { };
      move = { };
      operators = { };
      pairs = { };
      # snippets = { };
      splitjoin = { };
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
      basics = { };
      bracketed = { };
      bufremove = { };
      # clue = { };
      # deps = { };
      diff = { };
      extra = { };
      files = { };
      # jump = { };
      misc = { };
      sessions = { };
      visits = { };
      cursorword = { };
      hipatterns = { };
      # indentscope = { };
      notify = { };
      # starter = {
      #   autoopen = true;
      # };
      statusline = { };
      trailspace = { };
    };
  };
}
