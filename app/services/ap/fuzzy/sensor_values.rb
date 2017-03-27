module Ap
  module Fuzzy
    class SensorValues
      LIGHT = %w(DARK MOONLIGHT FOG CLEAR SUNNY).freeze
      TEMPERATURE = %w(FREEZE COLD COOL WARM HOT).freeze
      DISTANCE = %w(OVERLAP CLOSE NEARBY IN_RANGE FAR).freeze
      RAINDROP = %w(DRY CONDENSE DRIZZLE HEAVY_RAIN FLOOD).freeze
      HUMIDITY = %w(<20 20-40 40-60 60-80 >80).freeze
      VIBRATION = %w(<10 10-50 50-100 100-500 >500).freeze

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
    end
  end
end
