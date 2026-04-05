{ ... }:
{

  programs.nixvim.plugins = {
    render-markdown = {
      enable = true;
      settings = {
        bullet = {
          # icons = [
          #   "◆ "
          #   "• "
          #   "• "
          # ];
          enabled = true;
          render_modes = false;
          icons = [
            "󰫶 "
            "󱂉 "
          ];
          ordered_icons.__raw = ''
            function(ctx)
                local value = vim.trim(ctx.value)
                local index = tonumber(value:sub(1, #value - 1))
                return ('%d.'):format(index > 1 and index or ctx.index)
            end
          '';
          left_pad = 0;
          right_pad = 0;
          highlight = "RenderMarkdownBullet";
          scope_highlight = { };
          scope_priority = "nil";
        };
        code = {
          above = " ";
          below = " ";
          border = "thick";
          language_pad = 2;
          left_pad = 2;
          position = "right";
          right_pad = 2;
          sign = false;
          width = "block";
        };
        heading = {
          border = false;
          # icons = [
          #   "▼ "
          #   "▽ "
          #   "▼ "
          #   "▽ "
          #   "▼ "
          #   "▽ "
          # ];
          position = "inline"; # inline, overlay
          sign = false;
          width = "full";
          backgrounds = [
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        render_modes = true;
        indent = {
          enabled = true;
          skip_heading = false;
          highlight = "";
          icon = "";
        };
        signs = {
          enabled = false;
        };
      };
    };
  };
}
