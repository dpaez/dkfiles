-- Language servers with Neovim's built-in LSP client (needs Neovim 0.11+).
-- Server settings come from the nvim-lspconfig plugin (see vim/plug.vim);
-- the servers themselves are installed by the Brewfile.
--
-- Default keys: K hover, grn rename, gra code action, grr references,
-- gri implementation, gO symbols, [d / ]d prev/next diagnostic,
-- <C-s> signature help (insert mode). Added below: gd go to definition.
-- To add a language: install its server and add its name to this list
-- (names: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).

vim.lsp.enable({ 'ts_ls', 'eslint' })

vim.diagnostic.config({ virtual_text = true })
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      -- show the completion menu while typing
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to definition' })
  end,
})
