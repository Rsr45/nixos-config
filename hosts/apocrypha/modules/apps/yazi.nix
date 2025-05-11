{ ... }:
{
  programs.yazi.enable = true;

  home.file = {
    ".config/yazi/theme.toml".text = ''
      [status]
      sep_left = { open = "", close = "" }
      sep_right = { open = "", close = "" }

      [icon]
      globs = []
      dirs  = []
      files = []
      exts  = []
      conds = []
    '';
  };
  home.file = {
    ".config/yazi/init.lua".text = ''
                Header:children_add(function()
              	if ya.target_family() ~= "unix" then
            		return ""
              	end
              	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. " ")
                end, 500, Header.LEFT)
                Status:children_add(function(self)
      	local h = self._current.hovered
      	if h and h.link_to then
      		return " -> " .. tostring(h.link_to)
      	else
      		return ""
      	end
      end, 3300, Status.LEFT)
    '';
  };
}
