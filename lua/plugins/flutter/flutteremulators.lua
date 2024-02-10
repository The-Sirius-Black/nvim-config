-- flutter_emulators.lua

-- Function to run shell commands
function run_shell_command(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Function to get a list of available Flutter emulators
function get_flutter_emulators()
  local emulators_list = run_shell_command("flutter emulators")
  local emulators = {}

  for line in emulators_list:gmatch("[^\r\n]+") do
    local id, name, type, platform = line:match("([^•]+)•%s*([^•]+)•%s*([^•]+)•%s*([^•]+)")
    if id and name and type and platform then
      table.insert(
        emulators,
        {
          id = id:match("%S+"),
          name = name:match("%s*(.+)%s*"),
          type = type:match("%s*(.+)%s*"),
          platform = platform:match("%s*(.+)%s*"),
        }
      )
    end
  end

  return emulators
end

-- Function to launch the selected Flutter emulator
function launch_selected_emulator()
  local line_number = vim.fn.line(".")
  local emulator_id = vim.fn.matchlist(vim.fn.getline(line_number), "\\v^([^:]+):")[2]

  if emulator_id then
    run_shell_command("flutter emulators --launch " .. emulator_id)
    close_emulators_window()
  end
end

-- Function to close the Flutter emulators window
function close_emulators_window()
  local bufnr = vim.api.nvim_get_current_buf()
  local win_id = vim.api.nvim_get_current_win()

  vim.api.nvim_buf_delete(bufnr, { force = true })
  vim.api.nvim_win_close(win_id, true)
end

-- Function to open a centered floating window with decorated border and display Flutter emulators
-- Function to open a centered floating window and display Flutter emulators
function show_flutter_emulators()
  local emulators = get_flutter_emulators()

  -- Calculate window dimensions and position
  local width = 60
  local height = #emulators + 2
  local row = (vim.fn.winheight(0) - height) / 2
  local col = (vim.fn.winwidth(0) - width) / 2

  -- Create the content
  local lines = {}
  for _, emulator in ipairs(emulators) do
    table.insert(
      lines,
      emulator.id .. ": " .. emulator.name .. " (" .. emulator.type .. " - " .. emulator.platform .. ")"
    )
  end

  local content = table.concat(lines, "\n")

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.split(content, "\n"))

  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    zindex = 50,
    border = "rounded",
  })

  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<CR>",
    ":lua launch_selected_emulator()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":lua close_emulators_window()<CR>", { noremap = true, silent = true })

  vim.api.nvim_win_set_option(win_id, "winblend", 50)
end
