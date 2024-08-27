M = {}

-- generate string for my custom which keymaps.
--
-- for whichkey.register mapping will be using the symbol "*" so dont add another "*" to the desc.
function M.printf(desc)
  local personal_sym = "󰐝"
  return string.format("%s %s", personal_sym, desc)
end

return M
