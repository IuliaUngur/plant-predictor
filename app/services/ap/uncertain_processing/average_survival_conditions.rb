module Ap
  module UncertainProcessing
    class AverageSurvivalConditions
      def initialize(predictions)
        @predictions = predictions

        @average_survival = {
          light: 0.0,
          temperature: 0.0,
          distance: 0.0,
          raindrop: 0.0,
          humidity: 0.0,
          vibration: 0.0
        }

      end

      def averages
        average_survival_conditions
        @average_survival
      end

      def averages_classified
        average_survival_conditions

        # average_survival needed as is for calculating procentages
        @avg_classified_values = @average_survival.clone
        convert_to_classes(@avg_classified_values)
        @avg_classified_values
      end

      private

      def average_survival_conditions
        survival_predictions = @predictions.where('result LIKE ?', '%survives%')
        no_survivals = survival_predictions.count

        survival_predictions.each do |prediction|
          prediction.sensors.each do |sensor|
            if sensor.value.to_i.zero?
              sensor_constant_values = sensor.name.to_s.upcase.constantize
              @average_survival[sensor.name.to_sym] +=
                (sensor_constant_values.find_index(sensor.value).to_f / no_survivals)
            else
              @average_survival[sensor.name.to_sym] += (sensor.value.to_f / no_survivals)
            end
          end
        end
      end

      def convert_to_classes(set)
        set.keys.each do |sensor|
          if Object.constants.include?(sensor.upcase)
            set[sensor] = sensor.to_s.upcase.constantize[set[sensor].round]
          else
            set[sensor] = set[sensor].round
          end
        end
      end

    end
  end
end
