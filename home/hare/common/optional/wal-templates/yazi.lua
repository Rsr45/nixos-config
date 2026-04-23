-- Hostname
Header:children_add(function()
    local host = ya.host_name() or "host"
    local user = ya.user_name() or "user"
    local label = string.format("%s@%s", host, user)

    local accent = "{{ color4 }}"
    local bg = "{{ background }}"

    return ui.Line({
        -- ui.Span(" "):fg(accent):bg(accent),
        -- ui.Span(host):fg("{{background}}"):bg(accent),
        -- ui.Span("@"):fg("{{color1}}"):bg(accent),
        -- ui.Span(user):fg("{{background}}"):bg(accent),
        -- ui.Span(" "):fg(accent):bg(accent),
        -- Single piece
        -- ui.Span(""):fg(accent()):bg(bg),
        ui.Span(" " .. label .. " "):fg("{{ color4 }}"):bg("{{background}}"),
        -- ui.Span(""):fg(accent()):bg(bg),
    })
end, 500, Header.LEFT)

-- Status bar permissions
Status:children_add(function()
    local h = cx.active.current.hovered
    if not h then
        return ui.Line {}
    end

    local perm = h.cha:perm()
    if not perm then
        return ui.Line {}
    end

    local spans = {}
    for i = 1, #perm do
        local c = perm:sub(i, i)
        spans[i] = ui.Span(c):fg("black"):bg("red")
    end

    return ui.Line {
        ui.Span(" "):bg("{{background | darken(0.2)}}"),
        ui.Span(perm):fg("{{color4}}"):bg("{{background | darken(0.2)}}"),
        ui.Span(" "):bg("{{background | darken(0.2)}}"),
        -- ui.Span(""):fg("red"):bg("{{background}}"),

    }
end, 500, Status.RIGHT)

-- Status bar owner
-- Status:children_add(function()
--     local h = cx.active.current.hovered
--     if not h or ya.target_family() ~= "unix" then
--         return ""
--     end
--
--     return ui.Line {
--         ui.Span(" "):bg("{{color4}}"),
--         ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("{{background}}"):bg("{{color4}}"),
--         ui.Span(":"):fg("{{background}}"):bg("{{color4}}"):bold(),
--         ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("{{background}}"):bg("{{color4}}"),
--         ui.Span(" "):bg("{{color4}}"),
--     }
-- end, 500, Status.RIGHT)

-- Status Mode indicator
Status:children_add(function()
    local txt = ""
    local ok, mode = pcall(function()
        if cx and cx.active then
            if cx.active.mode then
                return cx.active.mode
            elseif cx.active.current and cx.active.current.mode then
                return cx.active.current.mode
            elseif cx.active.current and cx.active.current.op then
                return cx.active.current.op
            end
        end
        return "?"
    end)
    if not ok then mode = "?" end

    -- map long names to short labels
    local mode_map = {
        normal       = "NOR",
        selected     = "SEL",
        select       = "SEL",
        visual       = "VIS",
        visual_line  = "V-L",
        visual_block = "V-B",
        insert       = "INS",
        command      = "CMD",
        rename       = "REN",
        search       = "SEA",
        ["?"]        = "?",
    }

    local label = mode_map[tostring(mode):lower()] or tostring(mode):upper()

    return ui.Line({
        ui.Span(" "):bg("{{color4}}"),
        ui.Span(txt .. label):fg("{{background}}"):bg("{{color4}}"):bold(),
        ui.Span(" "):bg("{{color4}}"),
    })
end, 500)

-- Status bar time
-- Status:children_add(function()
--     local time = (cx.active.current.hovered.cha.mtime or 0) // 1
--     local ui_date = nil
--
--     if time == 0 then
--         ui_date = ""
--     else
--         ui_date = os.date("%A %b %d %H:%M %Y", time)
--     end
--
--     return ui.Line({
--         ui.Span(""):fg("black"):bg("magenta"),
--         ui.Span(" "):fg("black"):bg("magenta"),
--         ui.Span(ui_date):fg("black"):bg("magenta"),
--         ui.Span(" "):fg("black"):bg("magenta"),
--         ui.Span(""):fg("magenta"):bg("black"),
--     })
-- end, 500, Status.LEFT)


-- Statusline: modified time (no plugin)
Status:children_add(function()
    local h = nil
    if cx and cx.active and cx.active.current then
        if cx.active.current.hovered and cx.active.current.hovered.cha then
            h = cx.active.current.hovered
        elseif cx.active.current.cha then
            h = cx.active.current
        end
    end

    if not h or not h.cha then
        return ui.Line({ ui.Span(" No file ") })
    end

    -- Get modification time
    local mtime = h.cha.mtime or 0
    -- local mtime_str = mtime > 0 and os.date("%Y-%m-%d %H:%M", mtime // 1) or "?"
    local mtime_str = mtime > 0 and os.date("%y-%m-%d %H:%M", mtime // 1) or "?"

    -- Build statusline segment
    return ui.Line({
        ui.Span(" " .. mtime_str .. " "):fg("{{color4}}"):bg("{{background | darken(0.2)}}"),
    })
end, 500)

-- Statusline: creation time (no plugin)
-- Status:children_add(function()
--     local h = nil
--     if cx and cx.active and cx.active.current then
--         if cx.active.current.hovered and cx.active.current.hovered.cha then
--             h = cx.active.current.hovered
--         elseif cx.active.current.cha then
--             h = cx.active.current
--         end
--     end
--
--     if not h or not h.cha or not h.cha.btime then
--         return ui.Line({ ui.Span(" No creation info ") })
--     end
--
--     -- Get creation time
--     local ctime = h.cha.btime
--     local ctime_str = os.date("%Y-%m-%d %H:%M", ctime // 1)
--
--     -- Build statusline segment
--     return ui.Line({
--         ui.Span(" C: " .. ctime_str .. " "):fg("silver"):bold(),
--     })
-- end, 500)

-- Status:children_add(function(self)
-- local h = self._current.hovered
-- if h and h.link_to then
--     return " -> " .. tostring(h.link_to)
-- else
--     return ""
-- end
-- end, 3300, Status.LEFT)

Status:children_add(function(self)
    local h = self._current.hovered
    if h and h.link_to then
        return ui.Line({
            ui.Span("-> "):fg("{{ foreground}}"):bg("{{background | darken(0.2)}}"),
            ui.Span(tostring(h.link_to)):fg("{{foreground}}"):bg("{{background | darken(0.2)}}"),
        })
    else
        return ui.Line({})
    end
end, 3300, Status.LEFT)

Status:children_remove(1, Status.LEFT)  -- NOR
Status:children_remove(2, Status.LEFT)  -- size
Status:children_remove(3, Status.LEFT) -- permissions
Status:children_remove(5, Status.RIGHT) -- percent
Status:children_remove(4, Status.RIGHT) -- permissions
-- Status:children_remove(6, Status.RIGHT) -- position
