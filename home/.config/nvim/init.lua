-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

function GoToFileAndLine()
    -- find file under cursor
    local file_path = vim.fn.expand('<cWORD>')
    local line_number = nil
    -- Check if there's a line number specified using pattern matching
    local filename, line = file_path:match("^(.-):(%d+)$")
    if filename then
        file_path = filename
        if line then
            line_number = tonumber(line)
        end
    end

    -- Check if the file exists
    if vim.fn.filereadable(file_path) == 1 then
        -- Open the file
        vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    else
        vim.notify('Error: File not found - ' .. file_path, vim.log.levels.ERROR)
        return
    end

    -- If a line number was specified, go to that line
    if line_number then
        local total_lines = vim.fn.line('$')
        if line_number > total_lines then
            vim.notify('Warning: Line number exceeds total lines in file', vim.log.levels.WARN)
            line_number = total_lines
        end
        vim.api.nvim_win_set_cursor(0, {line_number, 0})
    end
end

vim.api.nvim_set_keymap('n', 'gf', ':lua GoToFileAndLine()<CR>', { noremap = true, silent = true })

require "lazy_setup"
-- require "polish"
