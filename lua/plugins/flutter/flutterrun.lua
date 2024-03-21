-- flutter_tools.lua
-- Function to run shell commands
function run_shell_command(command)
  local handle = io.popen(command)
  if handle == nil then
    print("Error running command: " .. command)
    return
  end
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Function to get a list of available Flutter devices
function get_flutter_devices()
  local devices_list = run_shell_command("flutter devices")
  local devices = {}

  for line in devices_list:gmatch("[^\r\n]+") do
    local name, id, type = line:match("([^•]+)•%s*([^•]+)•%s*([^•]+)")
    if name and id and type then
      table.insert(devices, {
        name = name:match("%s*(.+)%s*"),
        id = id:match("%S+"),
        type = type:match("%s*(.+)%s*"),
      })
    end
  end

  return devices
end

-- Function to open a tab and run Flutter app
function run_flutter_app(device_id)
  local cmd = "flutter run -d " .. device_id
  vim.api.nvim_command("botright vnew | vertical resize 70")
  terminal_bufnr = vim.fn.bufnr("%")
  vim.api.nvim_command("term " .. cmd)
  vim.api.nvim_command("set modifiable")
  -- Wait for the terminal to be ready
  vim.api.nvim_command("wincmd p")

  -- Move cursor to the end
  vim.api.nvim_feedkeys("G", "n", true)
end

function flutter_hot_reload()
  send_input_to_terminal("r")
end

function flutter_hot_restart()
  send_input_to_terminal("R")
end

function flutter_quit_app()
  send_input_to_terminal("q")
end

function send_input_to_terminal(keys)
  if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
    local prev_bufnr = vim.fn.bufnr("%")

    -- Switch to the terminal buffer temporarily
    vim.api.nvim_set_current_buf(terminal_bufnr)

    -- Enter insert mode, feed keys, and exit insert mode
    vim.api.nvim_command("normal! i")
    vim.api.nvim_feedkeys(keys, "n", true)
    vim.api.nvim_command("normal! <Esc>")
    -- putting delay to avoid changing buffer before entering keys in terminal
    vim.defer_fn(function()
      vim.api.nvim_set_current_buf(prev_bufnr)
    end, 1000)
  else
    print("No valid terminal buffer found.")
  end
end

-- Function to show Flutter devices and select a device to run the app
function show_flutter_devices()
  local devices = get_flutter_devices()

  local lines = {}
  for i, device in ipairs(devices) do
    table.insert(lines, i .. ": " .. device.name .. " (" .. device.type .. ")")
  end

  local content = table.concat(lines, "\n")

  -- Create a floating window with the device selection dialog
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.split(content, "\n"))

  local height = math.min(#lines + 2, 10) -- Limit height to a maximum of 10 lines for better visibility
  local win_id = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = 100,
    height = height,
    row = (vim.fn.winheight(0) - height) / 2,
    col = (vim.fn.winwidth(0) - 30) / 2,
    style = "minimal",
    zindex = 50,
    border = "rounded",
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<CR>", ":lua launch_selected_device()<CR>", {
    noremap = true,
    silent = true,
  })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":lua close_device_selection()<CR>", {
    noremap = true,
    silent = true,
  })

  -- Clear the processing status in the bottom status line
  vim.api.nvim_command("echohl None | echo ''")

  -- Function to launch the selected device
  _G.launch_selected_device = function()
    local line_number = vim.fn.line(".")
    local selected_device = devices[line_number]

    if selected_device then
      run_flutter_app(selected_device.id)
      close_device_selection()
    end
  end

  -- Function to close the device selection window
  _G.close_device_selection = function()
    vim.api.nvim_win_close(win_id, true)
  end
end

-- Function to run all Flutter tools sequentially
function run_flutter_tools()
  -- Display processing status in the bottom status line
  vim.api.nvim_command("echohl WarningMsg | echo 'Opening available devices.....' | echohl None")

  -- Run Flutter tools asynchronously
  vim.defer_fn(function()
    show_flutter_devices()
    -- Add more functions here if needed

    -- Clear the processing status in the bottom status line
    vim.api.nvim_command("echohl None | echo ''")
  end, 0)
end
