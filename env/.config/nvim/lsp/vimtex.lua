return {
	cmd = { 'texlab' },
	filetypes = { 'tex', 'bib' },
	root_markers = { '.git', 'texlab' },
	settings = {
		texlab = {
			auxDirectory = '.',
			build = {
				executable = 'latexmk',
				args = { '-pdf', '-interaction=nonstopmode', '-shell-escape' },
				onSave = true,
			},
			forwardSearch = {
				executable = 'zathura',
				args = { '--synctex-forward', '%l', '%f', '%p' },
			},
			chktex = {
				onOpenAndSave = true,
				onEdit = false,
			},
			diagnosticsDelay = 300,
		},
	},
}

