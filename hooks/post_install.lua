--- Extension point, called after PreInstall, can perform additional operations,
--- such as file operations for the SDK installation directory or compile source code
--- Currently can be left unimplemented!

function PLUGIN:PostInstall(ctx)
  local sep = package.config:sub(1,1)
  local is_windows = sep == "\\"

  local version = ctx.sdkInfo["matlab-vfox"].version
  local install_path = ctx.rootPath
  local products = "MATLAB"
  products = products:gsub(",", " ")

  -- Set mpm path based on OS
  --local mpm_path = is_windows and [[C:\Users\slahoti\mpm.exe]] or "mpm"
  local mpm_path = "mpm"

  -- Build the install command
  local cmd = string.format('%s install --release=%s --destination=%s --products=%s', mpm_path, version, install_path, products)

  print("[DEBUG] Running: " .. cmd)

  local res = os.execute(cmd)
  if res ~= 0 then
      error("MATLAB install failed")
  end

  return true

end