{ config, ... }:
{

  programs.yazi.enable = true;

  # home.file = {
  #   ".config/yazi/theme.toml".text = ''
  #     [status]
  #     sep_left = { open = "", close = "" }
  #     sep_right = { open = "", close = "" }
  #
  #     [icon]
  #     globs = []
  #     dirs  = []
  #     files = []
  #     exts  = []
  #     conds = []
  #
  #     [completion.active]
  #     bg = "#${config.lib.stylix.colors.base03}"
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #
  #     [completion.border]
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #
  #     [completion.inactive]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0C}"
  #     mime = "image/*"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0A}"
  #     mime = "video/*"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0A}"
  #     mime = "audio/*"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/zip"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/gzip"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/tar"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/bzip"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/bzip2"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/7z-compressed"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/rar"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #     mime = "application/xz"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #     mime = "application/doc"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #     mime = "application/pdf"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #     mime = "application/rtf"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #     mime = "application/vnd.*"
  #
  #     [[filetype.rules]]
  #     bold = true
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #     mime = "inode/directory"
  #
  #     [[filetype.rules]]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #     mime = "*"
  #
  #     [help.desc]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [help.footer]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [help.hovered]
  #     bg = "#${config.lib.stylix.colors.base03}"
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [help.on]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #
  #     [help.run]
  #     fg = "#${config.lib.stylix.colors.base0C}"
  #
  #     [input.border]
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #
  #     [input.selected]
  #     bg = "#${config.lib.stylix.colors.base03}"
  #
  #     [input.title]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [input.value]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [mgr]
  #     syntect_theme = "/nix/store/0rxri2bmbch9psd9h0m644z60ps5q63w-base16-gruvbox-material-dark-soft.tmTheme"
  #
  #     [mgr.border_style]
  #     fg = "#${config.lib.stylix.colors.base04}"
  #
  #     [mgr.count_copied]
  #     bg = "#${config.lib.stylix.colors.base0B}"
  #     fg = "#${config.lib.stylix.colors.base00}"
  #
  #     [mgr.count_cut]
  #     bg = "#${config.lib.stylix.colors.base08}"
  #     fg = "#${config.lib.stylix.colors.base00}"
  #
  #     [mgr.count_selected]
  #     bg = "#${config.lib.stylix.colors.base0A}"
  #     fg = "#${config.lib.stylix.colors.base00}"
  #
  #     [mgr.cwd]
  #     fg = "#${config.lib.stylix.colors.base0C}"
  #
  #     [mgr.find_keyword]
  #     bold = true
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #
  #     [mgr.find_position]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #
  #     [mgr.hovered]
  #     bg = "#${config.lib.stylix.colors.base02}"
  #     bold = true
  #
  #     [mgr.marker_copied]
  #     bg = "#${config.lib.stylix.colors.base0B}"
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #
  #     [mgr.marker_cut]
  #     bg = "#${config.lib.stylix.colors.base08}"
  #     fg = "#${config.lib.stylix.colors.base08}"
  #
  #     [mgr.marker_selected]
  #     bg = "#${config.lib.stylix.colors.base0A}"
  #     fg = "#${config.lib.stylix.colors.base0A}"
  #
  #     [mgr.preview_hovered]
  #     bg = "#${config.lib.stylix.colors.base02}"
  #     bold = true
  #
  #     [mode.normal_alt]
  #     bg = "#${config.lib.stylix.colors.base00}"
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #
  #     [mode.normal_main]
  #     bg = "#${config.lib.stylix.colors.base0D}"
  #     bold = true
  #     fg = "#${config.lib.stylix.colors.base00}"
  #
  #     [mode.select_alt]
  #     bg = "#${config.lib.stylix.colors.base00}"
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #
  #     [mode.select_main]
  #     bg = "#${config.lib.stylix.colors.base0B}"
  #     bold = true
  #     fg = "#${config.lib.stylix.colors.base00}"
  #
  #     [mode.unset_alt]
  #     bg = "#${config.lib.stylix.colors.base00}"
  #     fg = "#${config.lib.stylix.colors.base0F}"
  #
  #     [mode.unset_main]
  #     bg = "#${config.lib.stylix.colors.base0F}"
  #     bold = true
  #     fg = "#${config.lib.stylix.colors.base00}"
  #
  #     [pick.active]
  #     fg = "#${config.lib.stylix.colors.base0E}"
  #
  #     [pick.border]
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #
  #     [pick.inactive]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [status.perm_exec]
  #     fg = "#${config.lib.stylix.colors.base0B}"
  #
  #     [status.perm_read]
  #     fg = "#${config.lib.stylix.colors.base0A}"
  #
  #     [status.perm_sep]
  #     fg = "#${config.lib.stylix.colors.base0C}"
  #
  #     [status.perm_type]
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #
  #     [status.perm_write]
  #     fg = "#${config.lib.stylix.colors.base08}"
  #
  #     [status.progress_error]
  #     bg = "#${config.lib.stylix.colors.base00}"
  #     fg = "#${config.lib.stylix.colors.base08}"
  #
  #     [status.progress_label]
  #     bg = "#${config.lib.stylix.colors.base00}"
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [status.progress_normal]
  #     bg = "#${config.lib.stylix.colors.base00}"
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [tabs.active]
  #     bg = "#${config.lib.stylix.colors.base0D}"
  #     bold = true
  #     fg = "#${config.lib.stylix.colors.base00}"
  #
  #     [tabs.inactive]
  #     bg = "#${config.lib.stylix.colors.base01}"
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #
  #     [tasks.border]
  #     fg = "#${config.lib.stylix.colors.base0D}"
  #
  #     [tasks.hovered]
  #     bg = "#${config.lib.stylix.colors.base03}"
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [tasks.title]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [which.cand]
  #     fg = "#${config.lib.stylix.colors.base0C}"
  #
  #     [which.desc]
  #     fg = "#${config.lib.stylix.colors.base05}"
  #
  #     [which.mask]
  #     bg = "#${config.lib.stylix.colors.base02}"
  #
  #     [which.rest]
  #     fg = "#${config.lib.stylix.colors.base0F}"
  #
  #     [which.separator_style]
  #     fg = "#${config.lib.stylix.colors.base04}"
  #   '';
  # };
  # home.file = {
  #   ".config/yazi/init.lua".text = ''
  #     Header:children_add(function()
  #     if ya.target_family() ~= "unix" then
  #     return ""
  #     end
  #     return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. " ")
  #     end, 500, Header.LEFT)
  #     Status:children_add(function(self)
  #     local h = self._current.hovered
  #     if h and h.link_to then
  #     return " -> " .. tostring(h.link_to)
  #     else
  #     return ""
  #     end
  #     end, 3300, Status.LEFT)
  #   '';
  # };
}
