local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local output = result.stderr and result.stderr ~= '' and result.stderr or result.stdout or ''
    vim.notify(('Build failed for %s:\n%s'):format(name, output ~= '' and output or 'No build output.'), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then return end

    local name = ev.data.spec.name
    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
    elseif name == 'LuaSnip' and vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
    elseif name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

require 'kickstart.plugins.guess-indent'
require 'kickstart.plugins.gitsigns'
require 'kickstart.plugins.which-key'
require 'kickstart.plugins.tokyonight'
require 'kickstart.plugins.todo-comments'
require 'kickstart.plugins.mini'
require 'kickstart.plugins.telescope'
require 'kickstart.plugins.lazydev'
require 'kickstart.plugins.blink-cmp'
require 'kickstart.plugins.lspconfig'
require 'kickstart.plugins.conform'
require 'kickstart.plugins.treesitter'
require 'kickstart.plugins.debug'
require 'kickstart.plugins.indent_line'
require 'kickstart.plugins.lint'
require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.neo-tree'
require 'kickstart.plugins.trouble'
require 'kickstart.plugins.diffview'
require 'kickstart.plugins.vimbegood'
