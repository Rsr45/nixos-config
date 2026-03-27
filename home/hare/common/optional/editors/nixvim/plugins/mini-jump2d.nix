{ ... }:
{
  programs.nixvim = {
    plugins.mini-jump2d = {
      enable = true;
      settings = {
        labels = "arstgmneio";

        allowed_lines = {
          blank = false;
          cursor_at = false;
        };
        view = {
          dim = true;
          n_steps_ahead = 1;
        };
        mappings = {
          start_jumping = "S";
        };
      };
    };
    extraConfigLuaPost = ''
      local user_input_opts = function(input_fun) -- Copied
          local res = {
              spotter = function() return {} end,
              allowed_lines = { blank = false, fold = false },
          }

          res.hooks = {
              before_start = function()
                  local input = input_fun()
                  if input ~= nil then res.spotter = MiniJump2d.gen_spotter.pattern(vim.pesc(input)) end
              end,
          }
          return res
      end

      local getleapedstr = function(msg) -- gets two chars
          local _, char1 = pcall(vim.fn.getcharstr)
          local _, char2 = pcall(vim.fn.getcharstr)

          return char1 .. char2
      end

      local start = function() -- two chars, based on MiniJump2d.builtin_opts.single_character
          local leaped = user_input_opts(function() return getleapedstr() end)
          MiniJump2d.start(leaped)
      end

      vim.keymap.set({ "n", "x" }, "s", "<Nop>", { desc = "Start 2d jumping" })
      -- No repeat in operator pending mode... See mini.jump2d H.apply_config.
      vim.keymap.set({ "n", "x", "o" }, "s", start, { desc = "Start 2d jumping" })
    '';
  };
}
