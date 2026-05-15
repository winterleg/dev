---@diagnostic disable: undefined-global
vim.opt.clipboard = "unnamedplus"
vim.o.termguicolors = tr

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

vim.opt.winborder = "single"
vim.opt.guicursor = ""

vim.opt.wildignorecase = true

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true

vim.opt.switchbuf = 'usetab'

vim.opt.nu = true

_G.pdfReader = "zathura"
_G.webBrowser = "helium-browser"

local spaceNumber = 2
vim.opt.tabstop = spaceNumber
vim.opt.shiftwidth = spaceNumber
vim.opt.smartindent = true

local useTabs = false
if useTabs then
  vim.opt.softtabstop = nil
  vim.opt.expandtab = false
else
  vim.opt.softtabstop = spaceNumber
  vim.opt.expandtab = true
end

vim.opt.wrap = false
vim.opt.showbreak = "\\-"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 10
vim.opt.isfname:append("@-@")

vim.opt.signcolumn = "yes"

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{,}"
vim.opt.foldlevelstart = 99

vim.opt.updatetime = 50

vim.opt.cursorline = true

vim.opt.colorcolumn = { 80, 120, 180 }
vim.opt.textwidth = 80

vim.opt.list = false
vim.opt.listchars:append("space:·")

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.spell = false
vim.opt.spelllang = nil

-- vim.o.iskeyword = "a-z,A-Z,48-57,_,.,->"

_G.isWriteCommit = false

vim.api.nvim_create_user_command("ToggleWriteCommit", function()
  if isWriteCommit then
    isWriteCommit = false
  else
    isWriteCommit = true
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*",
      callback = function()
        if isWriteCommit then
          vim.cmd [[silent !git add .]]
          vim.cmd [[silent !git commit -m nvim-commit]]
        end
      end
    })
  end
end, {})

vim.api.nvim_create_user_command("OpenFirefox", function()
  vim.cmd [[!firefox %]]
end, {})

vim.api.nvim_create_user_command("T", function(opts)
  local cmd = opts.args
  if cmd == "" then cmd = vim.o.shell end

  if opts.range > 0 then
    local content
    local s = vim.fn.getpos("'<")
    local e = vim.fn.getpos("'>")

    -- Use yank to get the exact visual selection if the range matches the marks
    if opts.line1 == s[2] and opts.line2 == e[2] then
      local reg_save = vim.fn.getreg('z')
      local regtype_save = vim.fn.getregtype('z')
      vim.cmd('silent noautocmd normal! gv"zy')
      content = vim.fn.getreg('z')
      vim.fn.setreg('z', reg_save, regtype_save)
    else
      -- Fallback for non-visual ranges (like :%T or :10,20T)
      content = table.concat(vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false), "\n")
    end

    if content then
      -- Wrap in double quotes and escape internal double quotes for the shell pipe
      -- local wrapped = '"' .. content:gsub('"', '\\"') .. '"'
      cmd = string.format("%s %s", cmd, vim.fn.shellescape(content))
    end
  end
  vim.cmd("term " .. cmd)
  vim.cmd("startinsert")
end, {
  nargs = '?',
  range = true
})

if vim.g.neovide then
  vim.opt.nu = false
  vim.o.guifont = "Courier Prime:h18"
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.05)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.05)
  end)
end
