--- Extension point, called after PreInstall, can perform additional operations,
--- such as file operations for the SDK installation directory or compile source code
--- Currently can be left unimplemented!

function PLUGIN:PostInstall(ctx)
  local sep = package.config:sub(1,1)
  local is_windows = sep == "\\"
  local mpm_bin = is_windows and "mpm.exe" or "mpm"

  local version = ctx.sdkInfo["matlab-vfox"].version
  local install_path = ctx.rootPath
  --local mpm_path = install_path .. sep .. mpm_bin

  --local products = os.getenv("MATLAB_TOOLBOXES") or "MATLAB"
  local products = "MATLAB"
  products = products:gsub(",", " ")

  -- Use the full path to mpm.exe
  mpm_path = [[C:\\Users\\slahoti\\mpm.exe]]

  -- Only quote the path, not the entire command
  local cmd = string.format('%s install --release=%s --destination=%s --products=%s', mpm_path, version, install_path, products)
  --local cmd = [[C:\Users\slahoti\mpm.exe install --release=R2024b --destination=.version-fox\plugin\matlab-vfox\matlab-install --products=MATLAB]]
  --local cmd = [[runas /user:Administrator "C:\Users\slahoti\mpm.exe install --release=R2024b --destination=C:\Users\slahoti\.version-fox\plugin\matlab-vfox --products=MATLAB"]]

  print("[DEBUG] Running: " .. cmd)

  local res = os.execute(cmd)
  if res ~= 0 then
      error("MATLAB install failed")
  end
  return true
end