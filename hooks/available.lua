--- Return all available versions provided by this plugin
--- @param ctx table Empty table used as context, for future extension
--- @return table Descriptions of available versions and accompanying tool descriptions
function PLUGIN:Available(ctx)
  return {
      {
          version = "R2025a",
          note = "Latest Release"
      },
      {
          version = "R2024b",
          note = "Recommended"
      },
      {
          version = "R2024a"
      },
      {
          version = "R2023b",
          note = "LTS"
      }
  }
end