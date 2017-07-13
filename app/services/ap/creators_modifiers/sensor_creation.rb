module Ap
  module CreatorsModifiers
    class SensorCreation
      def initialize(name, value, prediction)
        @name = name
        @value = value
        @prediction = prediction
      end

      def perform
        return create_sensor(@value) if @value.to_i.zero?

        create_sensor(fuzzy_sensor_value)
      end

      def get_sensor_value
        fuzzy_sensor_value
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
        m[:max] = -1.0
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
end
