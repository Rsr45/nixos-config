{ ... }:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        icons_enabled = true;
        component_separators = {
          left = "|";
          right = "|";
        };
        section_separators = {
          left = "";
          right = "";
        };
        disabled_filetypes = [
          "snacks_dashboard"
        ];
      };
      sections = {
        lualine_a = [
          "mode"
        ];
        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
          {
            __unkeyed-1 = "buffers";
            buffers_color = {
              active = {
                gui = "bold";
              };
              inactive = {
                gui = "italic";
              };
            };
            symbols = {
              modified = " ●";
              alternate_file = "";
              directory = "";
            };
            mode = 2;
          }
        ];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            file_status = true;
            path = 3;
          }
        ];
        lualine_x = [
          "filesize"
        ];
        lualine_y = [
          "searchcount"
          "selectioncount"
          "lsp_status"
          "filetype"
        ];
        lualine_z = [
          "encoding"
          "location"
        ];
      };

      # sections = {
      #   lualine_a = [ "mode" ];
      #   lualine_b = [
      #     "branch"
      #     "diff"
      #     "diagnostics"
      #   ];
      #   lualine_c = [ "filename" ];
      #   lualine_x = [
      #     "encoding"
      #     "fileformat"
      #     "filetype"
      #   ];
      #   lualine_y = [ "progress" ];
      #   lualine_z = [ "location" ];
      # };
      # inactive_sections = {
      #   lualine_a = [ "mode" ];
      #   lualine_b = [
      #     "branch"
      #     "diff"
      #     "diagnostics"
      #   ];
      #   lualine_c = [ "filename" ];
      #   lualine_x = [
      #     "encoding"
      #     "fileformat"
      #     "filetype"
      #   ];
      #   lualine_y = [ "progress" ];
      #   lualine_z = [ "location" ];
      # };
    };
  };
}
