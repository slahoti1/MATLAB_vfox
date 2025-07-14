--- !!! DO NOT EDIT OR RENAME !!!
PLUGIN = {}

--- !!! MUST BE SET !!!
--- Plugin name
PLUGIN.name = "matlab-vfox"
--- Plugin version
PLUGIN.version = "0.1.0"
--- Plugin homepage
PLUGIN.homepage = "https://github.com/your/matlab-vfox"
--- Plugin license, please choose a correct license according to your needs.
PLUGIN.license = "MIT"
--- Plugin description
PLUGIN.description = "MATLAB plugin for vfox"

--- !!! OPTIONAL !!!
PLUGIN.minRuntimeVersion = "0.3.0"
PLUGIN.manifestUrl = "https://github.com/your/matlab-vfox/releases/download/manifest/manifest.json"
PLUGIN.notes = {
    -- "This is a sample note for users."
}
PLUGIN.legacyFilenames = {
    ".matlab-version"
}

--- Required: Tell vfox where your hook files are
PLUGIN.hooks = "hooks"

return PLUGIN