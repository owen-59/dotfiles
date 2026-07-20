local function focus_relative_workspace(n)
    local monitor = hl.get_active_monitor()
    local target_workspace = n

    if monitor and monitor.name == "HDMI-A-1" then
        target_workspace = n + 3
    end

    hl.dispatch(hl.dsp.focus({ workspace = tostring(target_workspace )}))
end

return focus_relative_workspace
