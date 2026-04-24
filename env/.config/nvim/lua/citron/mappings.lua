---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
vim.g.mapleader = " "

vim.g.fzf_layout = { window = { width = 1, height = 0.7, yoffset = 1 } }
vim.g.fzf_preview_window = { 'right:50%' }

vim.cmd([[
  command! -bang FilesNoPDF
    \ call fzf#vim#files(
    \   '',
    \   {
    \     'source': 'rg --files --hidden --no-ignore-vcs --glob "!*.pdf"',
    \     'options': [
    \       '--preview',
    \       'bat --style=numbers --color=always --line-range :500 {}',
    \       '--preview-window', 'right:40%',
    \       '--multi']
    \   },
    \   <bang>0
    \ )
]])

local function files_no_pdf_query()
  local query = vim.fn.input('Search: ')
  if query and query ~= '' then
    local handle = io.popen('fd --type f -E "*.pdf"')
    if handle == nil then return end
    local all_files = handle:read("*a")
    handle:close()

    local files = {}
    for line in all_files:gmatch("[^\r\n]+") do
      local basename = line:match("([^/]+)$")
      if basename and basename:lower():find(query:lower(), 1, true) then
        table.insert(files, line)
      end
    end

    if #files > 0 then
      vim.fn['fzf#vim#files']('', {
        source = files,
        options = {
          "--preview", "bat --style=numbers --color=always --line-range :500 {}",
          '--preview-window', 'right:20%',
          '--multi'
        }
      })
    end
  end
end

local function toggleWhiteSpace()
  if vim.o.list then
    vim.opt.list = false
  else
    vim.opt.list = true
  end
end

local function fzf_firefox()
  vim.fn['fzf#run']({
    source = "fd --type f",
    sink = function(selected)
      if selected and selected ~= "" then
        vim.fn.jobstart({ webBrowser, selected }, { detach = true })
      end
    end,
    options = {
      "--prompt", "Find File > ",
      "--preview", "bat --style=numbers --color=always --line-range :500 {}",
      '--preview-window', 'right:20%',
      "--multi"
    },
    window = vim.g.fzf_layout.window
  })
end

local function fzf_pdf()
  vim.fn['fzf#run']({
    source = "fd --type f --extension pdf",
    sink = function(selected)
      if selected and selected ~= "" then
        for file in selected:gmatch("[^\r\n]+") do
          vim.fn.jobstart({ pdfReader, file }, { detach = true })
        end
      end
    end,
    options = {
      "--prompt", "Find PDF > ",
      "--preview", "pdftotext {} - | head -n 200",
      '--preview-window', 'right:20%',
      "--multi"
    },
    window = vim.g.fzf_layout.window
  })
end

local mappings = {
  { "t",               "<C-q>",      [[<C-\><C-n>]] },
  { "n",               "<C-t>",      "<cmd>silent !tmux-goway<CR>" },
  { "n",               "<C-y>",      "<cmd>silent !tmux neww yazi-tmux<CR>" },
  { "n",               "ç",          "<CMD>Oil<CR>",                           { desc = "Open root directory" } },
  { "n",               "<leader>ç",  "<CMD>Oil .<CR>",                         { desc = "Open root directory" } },
  { "n",               "<ESC>",      "<CMD>noh<CR>" },
  { { "n", "v" },      "-",          "0" },
  { { "n", "v", "x" }, ";",          ":" },
  { { "n", "v", "x" }, ":",          ";" },
  { { "n", "v" },      "!",          ":!" },
  { { 'n', 'v', 'x' }, 'j',          'gj' },
  { { 'n', 'v', 'x' }, 'k',          'gk' },
  -- { { 'n', 'v', 'x' }, 'v',          '<C-v>' },
  -- { { 'n', 'v', 'x' }, '<C-v>',      'v' },
  { { "n", "v" },      "<leader>w",  "<CMD>write<CR>" },
  { "n",               "<leader>pf", ":FilesNoPDF<CR>",                        { desc = "Open fzf (no PDFs)" } },
  { "n",               "<leader>pr", files_no_pdf_query,                       { desc = "Open fzf (no PDFs) with query" } },
  { "n",               "<leader>pk", fzf_firefox,                              { desc = "Open file in Firefox with telescope" } },
  { "n",               "<leader>py", fzf_pdf },
  { "n",               "<leader>k",  ":!make<CR>",                             { desc = "Call make" } },
  { "n",               "<leader>sk", "<CMD>T make<CR>",                        { desc = "Call make" } },
  { "n",               "<leader>sa", function() vim.cmd([[normal! ggVG]]) end, { desc = "Select the entire file" } },
  { { "n", "v" },      "<leader>3",  "/" },
  { "n",               "<leader>tw", toggleWhiteSpace },
  { "n",               "<leader>x",  "<CMD>!chmod +x %<CR>",                   { silent = true } },
  { "n",               "<leader>pl", "<CMD>lua MiniFiles.open()<CR>" }
}

for _, value in ipairs(mappings) do
  local mode, keybind, command, options = value[1], value[2], value[3], value[4]

  vim.keymap.set(mode, keybind, command, options)
end
