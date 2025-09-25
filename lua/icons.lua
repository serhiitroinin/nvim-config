-- Centralized icon configuration for consistency
-- Using Nerd Font icons (https://www.nerdfonts.com/cheat-sheet)

local M = {}

-- UI Elements
M.ui = {
	arrow_right = "",
	arrow_left = "",
	arrow_down = "",
	arrow_up = "",
	chevron_right = "",
	chevron_down = "",
	check = "✓",
	close = "",
	plus = "",
	minus = "",
	dot = "•",
	line_vertical = "│",
	line_horizontal = "─",
	corner = "└",
	branch = "├",
	ellipsis = "…",
	separator = "▏",
	separator_thick = "┃",
	menu = "☰",
	search = "",
	settings = "",
	refresh = "",
}

-- File & Folder
M.file = {
	file = "",
	file_empty = "",
	files = "󰉓",
	folder = "",
	folder_open = "",
	folder_empty = "󰜌",
	folder_home = "󰉋",
	symlink = "",
}

-- Git
M.git = {
	branch = "",
	commit = "",
	diff = "",
	merge = "",
	pull_request = "",
	added = "",
	modified = "",
	removed = "✖",
	renamed = "󰁕",
	untracked = "",
	ignored = "",
	unstaged = "󰄱",
	staged = "󰄲",
	conflict = "",
}

-- Diagnostics & Status
M.diagnostics = {
	error = "󰅙",
	warn = "",
	info = "󰋼",
	hint = "󰌵",
	debug = "",
	trace = "󰁕",
	ok = "",
	pending = "󰄱",
	question = "",
}

-- Programming Languages & File Types
M.languages = {
	lua = "󰢱",
	python = "",
	javascript = "",
	typescript = "",
	react = "",
	vue = "",
	html = "",
	css = "",
	sass = "",
	json = "",
	yaml = "",
	toml = "",
	markdown = "",
	rust = "",
	go = "",
	ruby = "",
	php = "",
	java = "",
	c = "",
	cpp = "",
	csharp = "",
	dart = "",
	swift = "",
	kotlin = "",
	scala = "",
	haskell = "",
	elixir = "",
	erlang = "",
	clojure = "",
	vim = "",
	docker = "",
	kubernetes = "",
	terraform = "",
	nix = "",
	shell = "",
	fish = "",
	powershell = "",
	r = "",
	julia = "",
	matlab = "",
}

-- Development Tools
M.dev = {
	terminal = "",
	code = "",
	database = "",
	server = "",
	api = "",
	package = "",
	dependencies = "",
	test = "󰙨",
	debug = "",
	run = "",
	build = "",
	clean = "󰃢",
	watch = "",
	monitor = "",
	profile = "󰓅",
	benchmark = "󱎫",
}

-- Editor Actions
M.editor = {
	save = "",
	save_all = "󰳻",
	undo = "",
	redo = "",
	cut = "",
	copy = "",
	paste = "",
	delete = "",
	rename = "󰑕",
	format = "",
	comment = "",
	uncomment = "",
	indent = "",
	outdent = "",
	fold = "",
	unfold = "",
	zoom_in = "",
	zoom_out = "",
	split_horizontal = "",
	split_vertical = "",
	maximize = "",
	minimize = "",
}

-- Navigation
M.nav = {
	home = "",
	back = "",
	forward = "",
	up = "",
	down = "",
	left = "",
	right = "",
	jump_to = "󰷺",
	bookmark = "",
	bookmarks = "",
	history = "",
	recent = "",
	pin = "",
	unpin = "",
}

-- OS & Platform
M.os = {
	linux = "",
	ubuntu = "",
	debian = "",
	arch = "",
	fedora = "",
	centos = "",
	macos = "",
	windows = "",
	android = "",
	ios = "",
}

-- Misc
M.misc = {
	robot = "󰚩", -- AI/Bot
	lightning = "", -- Performance
	fire = "", -- Hot reload
	snowflake = "", -- Frozen/Lock
	gear = "", -- Settings
	wrench = "", -- Tools/Fix
	palette = "", -- Themes
	globe = "", -- Web
	cloud = "", -- Cloud services
	download = "",
	upload = "",
	sync = "",
	lock = "",
	unlock = "",
	key = "",
	shield = "󰞀", -- Security
	bell = "", -- Notifications
	bell_off = "",
	mail = "",
	calendar = "",
	clock = "",
	timer = "",
	plug = "", -- Plugins
	puzzle = "", -- Extensions
	layers = "󰕳", -- Stack/Layers
	list = "", -- Lists/TODOs
	table = "", -- Tables
	chart = "", -- Analytics
	help = "",
	info_circle = "",
	light_bulb = "", -- Ideas/Tips
	graduation = "󰑐", -- Learning
}

-- Special Neo-tree icons
M.neotree = {
	default = "*",
	symlink = "",
	modified = "[+]",
	git_added = M.git.added,
	git_modified = M.git.modified,
	git_deleted = M.git.removed,
	git_renamed = M.git.renamed,
	git_untracked = M.git.untracked,
	git_ignored = M.git.ignored,
	git_unstaged = M.git.unstaged,
	git_staged = M.git.staged,
	git_conflict = M.git.conflict,
}

-- Bufferline/Tabline
M.bufferline = {
	close = "",
	close_all = "",
	pin = "",
	unpin = "",
	modified = "●",
	readonly = "",
	separator = "▏",
}

-- Function to get icon with optional fallback
function M.get(category, name, fallback)
	if M[category] and M[category][name] then
		return M[category][name]
	end
	return fallback or ""
end

return M
