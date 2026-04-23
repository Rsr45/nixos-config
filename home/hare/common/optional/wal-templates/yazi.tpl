[mgr]
cwd = { fg = "{{ color4 }}", bg = "{{background}}" }

hovered         = { reversed = true }
preview_hovered = { underline = false }

find_keyword  = { fg = "{{ color2 }}", bold = true, italic = true, underline = false }
find_position = { fg = "{{ background }}", bold = true, italic = true }

marker_copied   = { fg = "{{ color11 }}", bg = "{{ color11 }}" }
marker_cut      = { fg = "{{ color8 }}", bg = "{{ color8 }}" }
marker_marked   = { fg = "{{ color13 }}", bg = "{{ color13 }}" }
marker_selected = { fg = "{{ color10 }}", bg = "{{ color10 }}" }

count_copied   = { fg = "{{ color1 }}", bg = "{{ color11 }}" }
count_cut      = { fg = "{{ color1 }}", bg = "{{ color8 }}" }
count_selected = { fg = "{{ color1 }}", bg = "{{ color10 }}" }

border_symbol = "│"
border_style  = { fg = "{{background | darken(0.2)}}" }

syntect_theme = ""

[tabs]
active = { fg = "{{ background }}", bg = "{{ color4 }}" }
inactive = { fg = "{{ color4 }}", bg = "{{ color0 }}" }
sep_inner = {open = "", close = ""}
sep_outer = {open = "", close = ""}

[indicator]
preview = {underline = false}
padding = { open = "▐", close = "▌" }

[status]
sep_left = {open = "", close = ""}
sep_right = {open = "", close = ""}
overall = { fg = "{{ background }}", bg = "{{ background | darken(0.2) }}" }

[select]
border   = { fg = "{{ color13 }}" }
active   = { fg = "{{ color14 }}", bold = true }
inactive = {}

[input]
border   = { fg = "{{ color13 }}" }
title    = {}
value    = {}
selected = {}

[completion]
border   = { fg = "{{ color13 }}" }
active   = {}
inactive = {}

icon_file    = ""
icon_folder  = ""
icon_command = ""

[tasks]
border  = { fg = "{{ color13 }}" }
title   = {}
hovered = { fg = "{{ color14 }}", underline = true }

[which]
cols            = 1
mask            = { bg = "{{ color0 }}" }
cand            = { fg = "{{ color12 }}" }
rest            = { fg = "{{ color2 }}" }
desc            = { fg = "{{ color12 }}" }
separator       = " : "
separator_style = { fg = "{{ foreground }}" }

[help]
on      = { fg = "{{ color13 }}" }
run     = { fg = "{{ color14 }}" }
desc    = {}
hovered = { bold = true }
footer  = { fg = "{{ color1 }}", bg = "{{ color5 }}" }

[notify]
title_info  = { fg = "{{ color11 }}" }
title_warn  = { fg = "{{ color10 }}" }
title_error = { fg = "{{ color8 }}" }

icon_info  = ""
icon_warn  = ""
icon_error = ""

[filetype]

rules = [
        { mime = "image/*", fg = "{{ color14 }}" },
        { mime = "{audio,video}/*", fg = "{{ foreground }}" },
        { mime = "application/*zip", fg = "{{ color8 }}" },
        { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}", fg = "{{ color8 }}" },
        { mime = "application/{pdf,doc,rtf,vnd.*}", fg = "{{ foreground }}" },
        { name = "*", is = "link", fg = "{{color5}}" },
        { name = "*/", is = "link", fg = "{{color5}}" },
        { name = "*", fg = "{{ foreground }}" },
        { name = "*/", fg = "{{ color4 }}" }
]
