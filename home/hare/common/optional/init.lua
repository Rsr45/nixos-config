dofile("theme.lua")

require("full-border"):setup {
    type = ui.Border.PLAIN
}

th.git = th.git or {}
th.git.modified = ui.Style():fg("blue")
th.git.deleted = ui.Style():fg("red"):bold()

th.git = th.git or {}
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.ignored_sign = "I"
th.git.updated_sign = "U"

require("git"):setup()
