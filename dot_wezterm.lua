local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local mux = wezterm.mux

config.window_background_opacity = 0.8
config.color_scheme = "OneDark (base16)"
config.enable_tab_bar = true
config.scrollback_lines = 10000
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

-- key bindings
config.keys = {
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
	{ key = "p", mods = "ALT", action = act.PaneSelect },
	{
		mods = "LEADER",
		key = "s",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }),
	},
}

for i = 1, 8 do
	-- ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

wezterm.on("gui-startup", function(cmd)
	-- allow `wezterm start -- something` to affect what we spawn
	-- in our initial window
	local args = {}
	if cmd then
		args = cmd.args
	end

	-- retodo workpace
	local project_dir = wezterm.home_dir .. "/repos/retodo"
	-- editor tab
	local editor_tab, editoer_pane, window = mux.spawn_window({
		workspace = "retodo",
		cwd = project_dir,
		args = args,
	})
	editor_tab:set_title("editor")
	editoer_pane:send_text("nvim .\n")
	-- build tab
	local build_tab, build_pane, _ = window:spawn_tab({
		cwd = project_dir .. "/app/web",
	})
	build_tab:set_title("build")
	build_pane:split({
		direction = "Bottom",
		size = 0.3,
		cwd = project_dir,
	})
	build_pane:split({
		size = 0.5,
		cwd = project_dir .. "/packages/db",
	})

	-- 最初のタブをアクティブにする
	editor_tab:activate()
	mux.set_active_workspace("retodo")
end)

return config
