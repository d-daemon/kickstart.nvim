local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Formatting ]]
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = true,
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      lua = true,
      python = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    lua = { 'stylua' },
    rust = { 'rustfmt' },
    python = { 'ruff_format' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    sql = { 'sqlfluff', 'sql_formatter', stop_after_first = true },
  },
  formatters = {
    sqlfluff = {
      cwd = require('conform.util').root_file { '.sqlfluff' },
      require_cwd = true,
    },
    sql_formatter = {
      cwd = require('conform.util').root_file { '.sql-formatter.json', '.git' },
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

-- vim: ts=2 sts=2 sw=2 et
