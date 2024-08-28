--  /user.getOS.lua
local getOS = {}

function getOS.get_os_name()
  local osname
  -- ask LuaJIT first
  if jit then
    return jit.os
  end

  -- Unix, Linux variants
  local fh, _ = assert(io.popen("uname -o 2>/dev/null", "r"))
  if fh then
    osname = fh:read()
  end

  return osname or "Windows"
end

-- const
getOS.OSX = "OSX"
getOS.LINUX = "Linux"
-- TODO: add more OS const

return getOS
