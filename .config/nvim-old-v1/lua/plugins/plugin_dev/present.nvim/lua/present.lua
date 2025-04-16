local M = {}

M.setup = function()
  -- nothing yet - user config
end

---@class present.Slides
---@fields slides string[]: The slides in the presentation

--- takes some lines and parses them
--- @param lines string[]: The lines in the buffer
--- @return present.Slides
local parse_slides = function(lines)
  local slides = { slides = {} }
  local current_slides = {}

  local separator = '^#'
  for _, line in ipairs(lines) do
    print(line, 'find:', line:find(separator), '|')
    if line:find(separator) then
      if #current_slides > 0 then
        table.insert(slides.slides, current_slides)
      end
      current_slides = {}
    end
    table.insert(current_slides, line)
  end

  table.insert(slides.slides, current_slides)
  return slides
end

vim.print(parse_slides {
  '# Hello',
  'Slide 1',
  '# Friend',
  'Slide 2',
})

return M
