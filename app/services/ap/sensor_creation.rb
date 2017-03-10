module Ap
  class SensorCreation
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

    def initialize(name, value, prediction)
      @name = name
      @value = value
      @prediction = prediction
    end

    def perform
      return create_sensor(@value) if @value.to_i.zero?

      create_sensor(fuzzy_sensor_value)
    end

    private

    def fuzzy_sensor_value
      service = "Ap::Fuzzy::#{@name.capitalize}".constantize
      results = service.new.perform(@value.to_i)

      return results if results.is_a? Numeric

      find_maximum_from_results(results)
    end

    def find_maximum_from_results(results)
      m={}
      m[:max] = -1.0;
      results.each do |key, value|
        if value > m[:max] then
          m[:max] = value
          m[:result] = key
        end
      end

      m[:result].to_s.upcase
    end

    def create_sensor(value)
      Sensor.create!(
        name: @name,
        measurement: value.to_i.zero? ? "limited" : "continuous",
        value: value,
        prediction_id: @prediction.id
      )
    end
  end
end
