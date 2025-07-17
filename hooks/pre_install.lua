--- Returns pre-install information, such as version number, download address, local files, etc.
--- If checksum is provided, vfox will automatically check it for you.
--- @param ctx table
--- @field ctx.version string User-input version
--- @return table Version information
--[[function PLUGIN:PreInstall(ctx)
  -- You can use ctx.version to customize the download URL per version if needed
  local version = ctx.version

  return {
      version = version,
      url = "https://example.com/matlab/" .. version .. "/matlab-installer.zip",
      -- sha256 = "your-sha256-checksum-here", -- optional
      -- md5 = "your-md5-checksum-here",       -- optional
      -- sha1 = "your-sha1-checksum-here",     -- optional
      -- sha512 = "your-sha512-checksum-here", -- optional
      -- addition = { ... }                    -- optional
  }
end]]


function PLUGIN:PreInstall(ctx)
  
  local version = ctx.version
  local os = jit.os:lower()
  local arch = jit.arch
  local mpm_url = ""
  local mpm_bin = "mpm"

  if os == "linux" then
      mpm_url = "https://www.mathworks.com/mpm/glnxa64/mpm"
  elseif os == "osx" then
      if arch == "arm64" then
          mpm_url = "https://www.mathworks.com/mpm/maca64/mpm"
      else
          mpm_url = "https://www.mathworks.com/mpm/maci64/mpm"
      end
  else
      mpm_url = "https://www.mathworks.com/mpm/win64/mpm"
  end

  --mpm_url = "https://www.mathworks.com/mpm/win64/mpm"

  return {
      version = version,
      url = mpm_url
      
  }
end

