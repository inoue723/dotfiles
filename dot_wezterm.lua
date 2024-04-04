local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()
 
wezterm.font("Cica")

config.window_background_opacity = 0.8
config.color_scheme = 'OneDark (base16)'

-- key bindings
config.keys = {}
for i = 1, 8 do
    -- ALT + number to activate that tab
    table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
    })
end

return config
