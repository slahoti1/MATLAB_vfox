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
    local mpm_url = ""
    local mpm_bin = "mpm"
    
    -- Detect OS using path separator
    local sep = package.config:sub(1,1)
    local os = ""
    if sep == "\\" then
        os = "windows"
    else
        local uname = io.popen("uname"):read("*l")
        os = uname:lower()
    end
    
    -- Detect architecture (optional fallback)
    local arch = os.getenv("PROCESSOR_ARCHITECTURE") or ""
    
    -- Set URL based on OS
    if os:find("linux") then
        mpm_url = "https://www.mathworks.com/mpm/glnxa64/mpm"
    elseif os:find("darwin") or os:find("mac") then
        if arch == "arm64" then
            mpm_url = "https://www.mathworks.com/mpm/maca64/mpm"
        else
            mpm_url = "https://www.mathworks.com/mpm/maci64/mpm"
        end
    else
        mpm_url = "https://www.mathworks.com/mpm/win64/mpm"
    end
    
    return {
        version = version,
        url = mpm_url
    }
    
end

