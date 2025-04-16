local M = {}

-- Function to print a welcome message to a friend
-- @param welcome_string: The welcome message to use
-- @param name: The name of the friend
-- @return nil
-- @usage hello.hello_friend("Hello", "friend")
function M.hello_friend(welcome_string,name)
  print(welcome_string .. " " .. name .. "!")
end

return M
