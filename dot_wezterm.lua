local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local mux = wezterm.mux

config.window_background_opacity = 0.85
config.color_scheme = "OneDark (base16)"
config.enable_tab_bar = true
config.scrollback_lines = 10000
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

-- key bindings
config.keys = {
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
	{ key = "p", mods = "ALT", action = act.PaneSelect },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ClearScrollback("ScrollbackAndViewport") },
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

local function createRetodoWorkace(args)
	local project_dir = wezterm.home_dir .. "/repos/retodo"
	local workspaceName = "retodo"
	-- editor window
	local editor_tab, editoer_pane, editor_window = mux.spawn_window({
		workspace = workspaceName,
		cwd = project_dir,
		args = args,
	})
	editor_tab:set_title("editor")
	editoer_pane:send_text("nvim .\n")

	-- 最初のタブをアクティブにする
	editor_tab:activate()

	-- cli window
	local cli_tab, cli_pane, cli_window = mux.spawn_window({
		cwd = project_dir,
		workspace = workspaceName,
		args = args,
	})

	cli_tab:set_title("cli")
	cli_pane:split({
		direction = "Bottom",
		size = 0.3,
		cwd = project_dir,
	})
	cli_pane:split({
		size = 0.5,
		cwd = project_dir .. "/packages/db",
	})
end

local function createRetodoRemixWorkspace(args)
	local project_dir = wezterm.home_dir .. "/repos/retodo-remix"
	local workspaceName = "retodo-remix"
	-- editor window
	local editor_tab, editoer_pane, editor_window = mux.spawn_window({
		workspace = workspaceName,
		cwd = project_dir,
		args = args,
	})
	editor_tab:set_title("editor")
	editoer_pane:send_text("nvim .\n")

	-- 最初のタブをアクティブにする
	editor_tab:activate()

	-- cli window
	local cli_tab, cli_pane, cli_window = mux.spawn_window({
		cwd = project_dir .. "/app/web",
		workspace = workspaceName,
		args = args,
	})

	cli_tab:set_title("cli")
	cli_pane:split({
		direction = "Bottom",
		size = 0.3,
		cwd = project_dir,
	})
	-- cli_pane:split({
	-- 	size = 0.5,
	-- 	cwd = project_dir .. "/packages/db",
	-- })
end

wezterm.on("gui-startup", function(cmd)
	-- allow `wezterm start -- something` to affect what we spawn
	-- in our initial window
	local args = {}
	if cmd then
		args = cmd.args
	end

	-- createRetodoWorkace(args)

	createRetodoRemixWorkspace(args)

	mux.set_active_workspace("retodo-remix")
end)

return config
