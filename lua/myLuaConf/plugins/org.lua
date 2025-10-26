return {
	{
		"orgmode",
		for_cat = "org",
		ft = "org",
		dep_of = { "org-roam.nvim", "org-bullets" },
		lazy = false,
		after = function()
			require("orgmode").setup({
				org_agenda_files = "~/Personal/Notes/orgfiles/**/*",
				org_default_notes_file = "~/Personal/Notes/orgfiles/refile.org",
				org_adapt_indentation = false,
				org_startup_indented = true,
			})
		end,
	},
	{
		"org-roam.nvim",
		for_cat = "org",
		ft = "org",
		lazy = false,
		after = function()
			require("org-roam").setup({
				directory = "~/Personal/Notes/orgroam",
			})
		end,
	},
	{
		"org-bullets",
		for_cat = "org",
		ft = "org",
		lazy = false,
		after = function()
			require("org-bullets").setup()
		end,
	},
}
