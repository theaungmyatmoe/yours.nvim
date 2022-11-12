local ok, telescope = pcall(require, "telescope")
if not ok then
	return
end

telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				-- ["<C-h>"] = "which_key"
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false,
			prompt_title = false,
			prompt_prefix = " 🔭 ",
		},
	},
	extensions = {},
})

telescope.load_extension("fzf")
