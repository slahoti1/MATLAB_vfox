--- Each SDK may have different environment variable configurations.
--- This allows plugins to define custom environment variables (including PATH settings)
--- Note: Be sure to distinguish between environment variable settings for different platforms!
--- @param ctx table Context information
--- @field ctx.path string SDK installation directory
--[[function PLUGIN:EnvKeys(ctx)
  local mainPath = ctx.path

  -- On Windows, use ';', on Unix, use ':'
  local sep = package.config:sub(1,1) == '\\' and ';' or ':'

  return {
      {
          key = "PATH",
          value = mainPath .. "\\bin" .. sep .. os.getenv("PATH")
      }
      -- You can add more variables like this:
      -- {
      --     key = "MATLAB_HOME",
      --     value = mainPath
      -- }
  }
end]]
function PLUGIN:EnvKeys(ctx)
  local mainPath = ctx.path
  local runtimeVersion = ctx.runtimeVersion
  local isWindows = package.config:sub(1,1) == '\\'
  local sdkInfo = ctx.sdkInfo['matlab-vfox']
  local path = sdkInfo.path
  local version = sdkInfo.version
  local name = sdkInfo.name

  local binPath
  if isWindows then
    binPath = mainPath .. "\\bin"
  else
    binPath = mainPath .. "/bin"
  end

  return {
    {
      key = "PATH",
      value = mainPath
    },
    {
      key = "PATH",
      value = binPath
    }
  }
end
