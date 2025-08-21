--- Extension point, called after PreInstall, can perform additional operations,
--- such as file operations for the SDK installation directory or compile source code
--- Currently can be left unimplemented!

function PLUGIN:PostInstall(ctx)
  
  local sep = package.config:sub(1,1)
  local is_windows = sep == "\\"

  local version = ctx.sdkInfo["matlab-vfox"].version
  local install_path = ctx.rootPath

  -- Get toolboxes from environment variable
  local toolboxes_env = os.getenv("MATLAB_TOOLBOXES")
  local products = "MATLAB"
  if toolboxes_env and #toolboxes_env > 0 then
    products = products .. "," .. toolboxes_env
  end
  products = products:gsub(",", " ")

-------------------------------
----trying the hashing


---- getting the directory and installation in there

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

-----------remove a directory
local function remove_dir(dir)
  local sep = package.config:sub(1,1)
  local cmd
  if sep == "\\" then
    -- Windows
    cmd = string.format('rmdir /s /q "%s"', dir)
  else
    -- Unix/Linux/Mac
    cmd = string.format('rm -rf "%s"', dir)
  end
  os.execute(cmd)
end


local function install_exists(install_dir)
  local sep = package.config:sub(1,1)
  local marker_file = install_dir .. sep .. "//bin//matlab.exe"  -- Or another marker file
  return file_exists(marker_file)
end

if not install_exists(install_dir) then
  print("Creating install directory: " .. install_dir)
  -- Cross-platform mkdir -p
  local is_windows = package.config:sub(1,1) == "\\"
  local mkdir_cmd
  if is_windows then
    mkdir_cmd = 'mkdir "' .. install_dir .. '"'
  else
    mkdir_cmd = 'mkdir -p "' .. install_dir .. '"'
  end
  assert(os.execute(mkdir_cmd), "Failed to create directory: " .. install_dir)

  -- Do your installation here
  print("Installing toolbox in " .. install_dir)
  -- ...installation logic...


-----------------------------

  -- Set mpm path based on OS
  --local mpm_path = is_windows and [[C:\Users\slahoti\mpm.exe]] or "mpm"
  local mpm_path = "mpm"

  -- Build the install command
  local cmd = string.format('%s install --release=%s --destination=%s --products=%s', mpm_path, version, install_dir, products)

  print("[DEBUG] Running: " .. cmd)

  local res = os.execute(cmd)
  if res ~= 0 then
      error("MATLAB install failed")
  end

else
  print("Installation already exists at " .. install_dir .. ". Skipping install.")
end

remove_dir(parent_dir .. sep .. version)

  return true
end