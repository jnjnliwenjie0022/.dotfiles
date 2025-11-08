local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local mux = wezterm.mux

-- window
wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "RESIZE"

-- Tab
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

-- word
config.font_size = 20
config.line_height = 0.85

-- color
config.term = "xterm-256color"
config.color_scheme = 'Catppuccin Mocha'
config.colors = {
    background = 'black'
}

-- bell
config.audible_bell = "Disabled"

-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

return config
