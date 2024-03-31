local wezterm = require 'wezterm'

local config = wezterm.config_builder()
 
wezterm.font("Cica")

config.color_scheme = 'OneDark (base16)'

return config
