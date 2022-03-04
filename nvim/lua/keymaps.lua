local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
	insert_mode = generic_opts_any,
	normal_mode = generic_opts_any,
	visual_mode = generic_opts_any,
	visual_block_mode = generic_opts_any,
	command_mode = generic_opts_any,
	term_mode = { silent = true },
}

local mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", generic_opts_any)

local defaults = {
	---@usage change or add keymappings for normal mode
	normal_mode = {
		-- Better window movement
		["<A-h>"] = "<C-w>h",
		["<A-j>"] = "<C-w>j",
		["<A-k>"] = "<C-w>k",
		["<A-l>"] = "<C-w>l",

		-- Resize with arrows
		["<C-w>"] = ":resize -2<CR>",
		["<C-s>"] = ":resize +2<CR>",
		["<C-d>"] = ":vertical resize -2<CR>",
		["<C-a>"] = ":vertical resize +2<CR>",

		-- Tab switch buffer
		["<TAB>"] = ":BufferLineCycleNext<CR>",
		["<S-TAB>"] = ":BufferLineCyclePrev<CR>",
		-- QuickFix
		["]q"] = ":cnext<CR>",
		["[q"] = ":cprev<CR>",
		["<C-q>"] = ":call QuickFixToggle()<CR>",
		["<C-Space>"] = ":FloatermToggle<cr>",
	},

	---@usage change or add keymappings for insert mode
	insert_mode = {
		-- 'jk' for quitting insert mode
		["jk"] = "<ESC>",
		-- 'kj' for quitting insert mode
		["kj"] = "<ESC>",
		-- 'jj' for quitting insert mode
		["jj"] = "<ESC>",
		-- Move current line / block with Alt-j/k ala vscode.
		["<A-j>"] = "<Esc>:m .+1<CR>==gi",
		-- Move current line / block with Alt-j/k ala vscode.
		["<A-k>"] = "<Esc>:m .-2<CR>==gi",
		-- Navigation
		["<C-e>"] = "<C-o>$",
		["<C-q>"] = "<C-o>0",
		["<C-a>"] = "<Left>",
		["<C-d>"] = "<Right>",
		["<C-w>"] = "<Up>",
		["<C-s>"] = "<Down>",
	},

	---@usage change or add keymappings for terminal mode
	term_mode = {
		-- Terminal window navigation
		["<A-n>"] = "<C-\\><C-N>:FloatermNew<cr>",
		["<A-h>"] = "<C-\\><C-N>:FloatermPrev<cr>",
		["<A-l>"] = "<C-\\><C-N>:FloatermNext<cr>",
		["<A-d>"] = "<C-\\><C-N>:FloatermKill<cr>:FloatermToggle<cr>",
		["<C-Space>"] = "<C-\\><C-N>:FloatermToggle<cr>",
	},

	---@usage change or add keymappings for visual mode
	visual_mode = {
		-- Better indenting
		["<"] = "<gv",
		[">"] = ">gv",
		["/"] = ":CommentToggle<cr>",

		-- ["p"] = '"0p',
		-- ["P"] = '"0P',
	},

	---@usage change or add keymappings for visual block mode
	visual_block_mode = {
		-- Move selected line / block of text in visual mode
		["K"] = ":move '<-2<CR>gv-gv",
		["J"] = ":move '>+1<CR>gv-gv",

		-- Move current line / block with Alt-j/k ala vscode.
		["<A-j>"] = ":m '>+1<CR>gv-gv",
		["<A-k>"] = ":m '<-2<CR>gv-gv",
	},

	---@usage change or add keymappings for command mode
	command_mode = {
		-- navigate tab completion with <c-j> and <c-k>
		-- runs conditionally
		["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
		["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
	},
}

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
local set_keymaps = function(mode, key, val)
	local opt = generic_opts[mode] or generic_opts_any
	if type(val) == "table" then
		opt = val[2]
		val = val[1]
	end
	if val then
		vim.api.nvim_set_keymap(mode, key, val, opt)
	else
		pcall(vim.api.nvim_del_keymap, mode, key)
	end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
local function load_mode(mode, keymaps)
	mode = mode_adapters[mode] or mode
	for k, v in pairs(keymaps) do
		set_keymaps(mode, k, v)
	end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
local function load(keymaps)
	keymaps = keymaps or {}
	for mode, mapping in pairs(keymaps) do
		load_mode(mode, mapping)
	end
end

-- Load the default keymappings
load(defaults)
