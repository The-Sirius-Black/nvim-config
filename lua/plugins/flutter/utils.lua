function run_shell_command(command)
  local handle = io.popen(command)
  --nil check for handle
  if handle == nil then
    print("Error running command: " .. command)
    return
  end
  local result = handle:read("*a")
  handle:close()
  return result
end

function build_runner_run()
  local cmd = "flutter pub run build_runner run"
  vim.api.nvim_command("botright vnew | vertical resize 70")
  terminal_bufnr = vim.fn.bufnr("%")
  vim.api.nvim_command("term " .. cmd)
  vim.api.nvim_command("set modifiable")
  vim.api.nvim_command("wincmd p")
  vim.api.nvim_feedkeys("G", "n", true)
  vim.api.nvim_command("wincmd l")
end

function gen_localizations()
  local cmd = "flutter gen-l10n"
  vim.api.nvim_command("botright vnew | vertical resize 70")
  terminal_bufnr = vim.fn.bufnr("%")
  vim.api.nvim_command("term " .. cmd)
  vim.api.nvim_command("set modifiable")
  vim.api.nvim_command("wincmd p")
  vim.api.nvim_feedkeys("G", "n", true)
  vim.api.nvim_command("wincmd l")
end
