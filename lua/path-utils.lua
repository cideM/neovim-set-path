local module = {}

-- Inspired by https://github.com/Guergeiro/clean-path.vim/blob/master/plugin/clean-path.vim
function module.set_path()
    -- Run system command and read result without newlines
    -- Careful if command returns a newline delimited list
    local handle = io.popen("git rev-parse --show-toplevel 2> /dev/null")
    local result = string.gsub(handle:read("*a"), "\n", "")

    if result ~= "" then
      local files_handle = io.popen("git ls-files " .. result .. " | xargs dirname " .. result)
      local files_result = files_handle:read("*a")

      -- Create a list of all directories fd found
      local paths = {}
      -- Split string by matching all non-whitespace character groups
      for v in string.gmatch(files_result, "%S+") do
        if v ~= "" then
          table.insert(paths, v)
        end
      end

      local path = pcall(vim.bo,"path") or ""

      if path ~= nil then
          for v in string.gmatch(path, "[^,]+") do
            if v ~= "" then
              table.insert(paths, v)
            end
          end
      end

      -- Make list of directories unique
      -- Includes both current path and new directories
      local seen = {}
      local unique = {}
      for _, v in ipairs(paths) do
        if not seen[v] then
          table.insert(unique, v)
          seen[v] = true
        end
      end

      -- Set path and clean up
      vim.bo.path = table.concat(unique, ",")
      files_handle:close()
    end

    handle:close()
end

return module
