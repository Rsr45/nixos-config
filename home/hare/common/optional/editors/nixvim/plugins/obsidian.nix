{ ... }:
{
  programs.nixvim.keymaps = [
    # {
    #   key = "<leader>nc";
    #   mode = [ "n" ];
    #   action = "<cmd>Obsidian new<Cr>";
    #   options.desc = "Note Create";
    # }
    # {
    #   key = "<leader>nd";
    #   mode = [ "n" ];
    #   action = "<cmd>Obsidian dailies<Cr>";
    #   options.desc = "New Daily";
    # }
    # {
    #   key = "<leader>ns";
    #   mode = [ "n" ];
    #   action = "<cmd>Obsidian search<Cr>";
    #   options.desc = "Search Notes";
    # }
    # {
    #   key = "<leader>nt";
    #   mode = [ "n" ];
    #   action = "<cmd>Obsidian tags<Cr>";
    #   options.desc = "Search Tags";
    # }
    {
      key = "<leader>fn";
      mode = [ "n" ];
      action = "<cmd>Obsidian quick_switch<Cr>";
      options.desc = "Find Note";
    }
    {
      key = "<leader>fl";
      mode = [ "n" ];
      action = "<cmd>Obsidian follow_link<Cr>";
      options.desc = "Follow Link";
    }
    {
      key = "<leader>cl";
      mode = [ "v" ];
      action = "<cmd>Obsidian link_new<Cr>";
      options.desc = "Create Link";
    }
  ];

  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      ui.enable = false;
      legacy_commands = false;

      workspaces = [
        {
          name = "Personal";
          path = "~/Personal/Vaults/Personal";
          overrides = {
            notes_subdir = "temp";
            attachments = {
              folder = "99_Meta/01_Attachments";
            };
          };
        }
        {
          name = "Work";
          path = "~/Personal/Vaults/Dev";
        }
      ];

      templates = {
        folder = "99_Meta/00_Templates";
        date_format = "%Y-%m-%d";
        time_format = "%H:%M";
        # substitutions = {};
        # customizations = {};
      };

      daily_notes = {
        folder = "daily";
        date_format = "%Y-%m-%d";
        alias_format = "%B %-d, %Y";
        default_tags = [ "Daily" ];
      };

      note_id_func.__raw = ''
        ---@param title string|?
        ---@return string
        function(title)
            -- Create note IDs in a Zettelkasten format with a datetime and a suffix.
            -- In this case a note with the title 'My new note' inside folder named 'VIM' will be given an ID that looks
            -- like '202502132345-FRXT-VIM-my_new_note', and therefore the file name '202502132345-FRXT-VIM-my_new_note.md'.
            local suffix = ""
            local folder_path = vim.fn.expand('%:p:h')
            local folder_name = vim.fn.fnamemodify(folder_path, ':t')
            local folder_prefix = folder_name:sub(1, 3):upper()
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = suffix ..
                    string.char(math.random(65, 90)) ..
                    string.char(math.random(65, 90)) ..
                    string.char(math.random(65, 90)) ..
                    string.char(math.random(65, 90)) ..
                    "-" ..
                    title:gsub(" ", "_"):gsub("[^A-Za-z0-9_-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90)) .. "-"
                end
            end
            -- return tostring(os.time()) .. "-" .. suffix
            return tostring(os.date("%Y%m%d%H%M")) .. "-" .. suffix
        end
      '';

      frontmatter = {
        enabled = true;
        func.__raw = ''
          function(note)
            local out = { id = note.id, aliases = note.aliases, tags = note.tags, title = note.aliases }
              if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                  out[k] = v
              end
            end

          return out
          end
        '';
        sort = [
          "id"
          "aliases"
          "tags"
          "title"
        ];
      };

    };
  };
}
