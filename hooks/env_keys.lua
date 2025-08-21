--- Each SDK may have different environment variable configurations.
--- This allows plugins to define custom environment variables (including PATH settings)
--- Note: Be sure to distinguish between environment variable settings for different platforms!
--- @param ctx table Context information
--- @field ctx.path string SDK installation directory

function PLUGIN:EnvKeys(ctx)
  --- this variable is same as ctx.sdkInfo['plugin-name'].path
  local mainPath = ctx.path
  local runtimeVersion = ctx.runtimeVersion
  local sep = package.config:sub(1,1) == '\\' and ';' or ':'
  local sdkInfo = ctx.sdkInfo['matlab-vfox']
  local path = sdkInfo.path
  local version = sdkInfo.version
  local name = sdkInfo.name

-----------------------
----custom directory

 -- Get toolboxes from environment variable
 local toolboxes_env = os.getenv("MATLAB_TOOLBOXES")

 if toolboxes_env then
  print("[DEBUG] MATLAB_TOOLBOXES env variable is set to: '" .. toolboxes_env .. "'")
  io.stderr:write("[DEBUG] MATLAB_TOOLBOXES env variable is set to: '" .. toolboxes_env .. "'\n")
else
  print("[DEBUG] MATLAB_TOOLBOXES env variable is NOT set or is nil")
  io.stderr:write("[DEBUG] MATLAB_TOOLBOXES env variable is NOT set or is nil\n")
end



 local products = "MATLAB"
 if toolboxes_env and #toolboxes_env > 0 then
   products = products .. "," .. toolboxes_env
 end
 products = products:gsub(",", " ")


local install_path = mainPath
local folder_name
if not toolboxes_env or #toolboxes_env == 0 then
  folder_name = "myMATLAB_" .. version
elseif toolboxes_env == "Simulink" then
  folder_name = "mySimulink_" .. version
else
  folder_name = "myOtherToolboxes_" .. version
end

-- Get parent directory of install_path
local sep = package.config:sub(1,1)
local parent_dir = install_path:match("^(.*" .. sep .. ")") or "."

-- Remove trailing separator if present
if parent_dir:sub(-1) == sep then
  parent_dir = parent_dir:sub(1, -2)
end

-- Concatenate parent directory and new folder name
local install_dir = parent_dir .. sep .. folder_name

-- Function to check if directory exists
local function file_exists(path)
  local f = io.open(path, "r")
  if f then f:close(); return true end
  return false
end

local function install_exists(install_dir)
  local sep = package.config:sub(1,1)
  local marker_file = install_dir .. sep .. "//bin//matlab.exe"  -- Or another marker file
  return file_exists(marker_file)
end

if not install_exists(install_dir) then
  io.stderr:write("WARNING: Required installation not present at " .. install_dir .. "\n")
  -- Return an empty table so mise/vfox does not error
  --return {}
  mainPath = install_dir
else
  -- Add to PATH
 mainPath = install_dir
-----------------------
end

return {
  {
    key = "PATH",
    value = mainPath
  },

  {
    key = "PATH",
    value = mainPath .. "\\bin"
  }

}

end