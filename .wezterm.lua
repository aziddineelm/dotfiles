-- Pull in WezTerm API
local wezterm = require("wezterm")

-- Utility functions
local window_background_opacity = 0.85
local function toggle_window_background_opacity(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1.0
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end
wezterm.on("toggle-window-background-opacity", toggle_window_background_opacity)

local function toggle_ligatures(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.harfbuzz_features then
		overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	else
		overrides.harfbuzz_features = nil
	end
	window:set_config_overrides(overrides)
end
wezterm.on("toggle-ligatures", toggle_ligatures)

-- Returns color scheme dependant on operating system theme setting (dark/light)
-- local function color_scheme_for_appearance(appearance)
-- 	if appearance:find("Dark") then
-- 		return "Tokyo Night"
-- 	else
-- 		return "Tokyo Night Day"
-- 	end
-- end

-- Initialize actual config
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Appearance
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13.5
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = window_background_opacity
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false
config.use_fancy_tab_bar = false

-- Keybindings
config.keys = {
	{ key = "O", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("toggle-window-background-opacity") },
	{ key = "E", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("toggle-ligatures") },
	-- Quickly open config file with common macOS keybind
	{
		key = ",",
		mods = "SUPER",
		action = wezterm.action.SpawnCommandInNewWindow({
			cwd = os.getenv("WEZTERM_CONFIG_DIR"),
			args = { os.getenv("SHELL"), "-c", "$VISUAL $WEZTERM_CONFIG_FILE" },
		}),
	},
	-- Switch between panes using Ctrl + h/j/k/l
	{ key = "h", mods = "ALT|SUPER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "ALT|SUPER", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "ALT|SUPER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "ALT|SUPER", action = wezterm.action.ActivatePaneDirection("Down") },
	-- Resize panes using Alt + h/j/k/l
	{ key = "h", mods = "CTRL|SUPER", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "l", mods = "CTRL|SUPER", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "k", mods = "CTRL|SUPER", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "j", mods = "CTRL|SUPER", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
}

-- Return config to WezTerm
return config
