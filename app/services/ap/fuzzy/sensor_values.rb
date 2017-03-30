module Ap
  module Fuzzy
    class SensorValues
      LIGHT = %w(DARK MOONLIGHT FOG CLEAR SUNNY).freeze
      TEMPERATURE = %w(FREEZE COLD COOL WARM HOT).freeze
      DISTANCE = %w(OVERLAP CLOSE NEARBY IN_RANGE FAR).freeze
      RAINDROP = %w(DRY CONDENSE DRIZZLE HEAVY_RAIN FLOOD).freeze
      HUMIDITY = %w(0-20 20-40 40-60 60-80 80-100).freeze
      VIBRATION = %w(0-10 10-50 50-100 100-500 500-1024).freeze

      LIGHT_SYM = [[:light, "DARK"], [:light, "MOONLIGHT"], [:light, "FOG"], [:light, "CLEAR"], [:light, "SUNNY"]]
      TEMPERATURE_SYM = [[:temperature, "FREEZE"], [:temperature, "COLD"], [:temperature, "COOL"], [:temperature, "WARM"], [:temperature, "HOT"]]
      DISTANCE_SYM = [[:distance, "OVERLAP"], [:distance, "CLOSE"], [:distance, "NEARBY"], [:distance, "IN_RANGE"], [:distance, "FAR"]]
      RAINDROP_SYM = [[:raindrop, "DRY"], [:raindrop, "CONDENSE"], [:raindrop, "DRIZZLE"], [:raindrop, "HEAVY_RAIN"], [:raindrop, "FLOOD"]]
      HUMIDITY_SYM = [[:humidity, "0-20"], [:humidity, "20-40"], [:humidity, "40-60"], [:humidity, "60-80"], [:humidity, "80-100"]]
      VIBRATION_SYM = [[:VIBRATION, "0-10"], [:VIBRATION, "10-50"], [:VIBRATION, "50-100"], [:VIBRATION, "100-500"], [:VIBRATION, "500-1024"]]

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
