local hello = require 'plugin_dev.my_plugin.hello'
local M = {}
-- The default welcome string
M.welcome_string = 'Hello'

-- Setup the plugin with given options
-- @param opts: Table containing options for the plugin
--   - welcome_string (string): The welcome message to use. Default is "Hello".
function M.setup(opts)
  -- Set the welcome string if provided in opts
  if opts and opts.welcome_string then
    M.welcome_string = opts.welcome_string
  end

  -- Create a user command 'HelloFriend'
  vim.api.nvim_create_user_command('HelloFriend', function(cmd_opts)
    -- print(vim.inspect(cmd_opts)) -- Uncomment for debugging

    -- Get the name argument or default to "friend"
    local name = (cmd_opts.args ~= '' and cmd_opts.args) or 'friend'

    -- Call the hello_friend function with the welcome string and name
    hello.hello_friend(M.welcome_string, name)
  end, { nargs = '?' }) -- nargs = "?" means 0 or 1 argument
end

return M
