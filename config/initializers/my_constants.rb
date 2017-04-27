EMPTY_SLOT = {
  light: '',
  temperature: '',
  distance: '',
  raindrop: '',
  humidity: '',
  vibration: ''
}

LIGHT = %w(DARK MOONLIGHT FOG CLEAR SUNNY).freeze
TEMPERATURE = %w(FREEZE COLD COOL WARM HOT).freeze
DISTANCE = %w(OVERLAP CLOSE NEARBY IN_RANGE FAR).freeze
RAINDROP = %w(DRY CONDENSE DRIZZLE HEAVY_RAIN FLOOD).freeze

LIGHT_SYM = [[:light, "DARK"], [:light, "MOONLIGHT"], [:light, "FOG"], [:light, "CLEAR"], [:light, "SUNNY"]].freeze
TEMPERATURE_SYM = [[:temperature, "FREEZE"], [:temperature, "COLD"], [:temperature, "COOL"], [:temperature, "WARM"], [:temperature, "HOT"]].freeze
DISTANCE_SYM = [[:distance, "OVERLAP"], [:distance, "CLOSE"], [:distance, "NEARBY"], [:distance, "IN_RANGE"], [:distance, "FAR"]].freeze
RAINDROP_SYM = [[:raindrop, "DRY"], [:raindrop, "CONDENSE"], [:raindrop, "DRIZZLE"], [:raindrop, "HEAVY_RAIN"], [:raindrop, "FLOOD"]].freeze

# temperature
#   - { arduino: degrees C - float }
#   - { after fuzzy: freeze, cold, cool, warm, hot }
# light
#   - { arduino: "DARK", "MOONLIGHT", "FOG", "CLEAR", "SUNNY" }
#   - { after fuzzy: dark, moonlight, fog, clear, sunny }
# vibration
#   - { arduino: value - float }
#   - { after fuzzy: value - float }
# distance
#   - { arduino: value - float }
#   - { after fuzzy: overlap, close, nearby, in_range, far }
# humidity
#   - { arduino: procentage - float/int 0-100 }
#   - { after fuzzy: procentage - float/int 0-100}
# raindrop
#   - { arduino: "DRY", "CONDENSE", "DRIZZLE", "HEAVY RAIN", "FLOOD" }
#   - { after fuzzy: dry, condense, drizzle, heavy_rain, flood }
