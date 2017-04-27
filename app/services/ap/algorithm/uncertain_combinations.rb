module Ap
  module Algorithm
    class UncertainCombinations
      def initialize(set, prediction_to_analyze)
        @set = set
        @prediction_to_analyze = prediction_to_analyze
        @combinations = []
      end

      def perform
        generate_combinations(@set)
        @combinations
      end

      private

      def generate_combinations(set)
        set.each do |hypotheses|
          # Difference between sets (@S - p; p - @S)
          set_without_prediction = (hypotheses.to_a - @prediction_to_analyze.sensor_set.to_a).to_h
          prediction_without_set = (@prediction_to_analyze.sensor_set.to_a - hypotheses.to_a).to_h

          # Intersection (@S ∩ p)
          set_intersect_prediction = (hypotheses.to_a & @prediction_to_analyze.sensor_set.to_a).to_h

          # Analyze hypotheses unique attributes for empty slots ( get_empty(@S - p) )
          non_empty_set_sensors = (set_without_prediction.to_a - EMPTY_SLOT.to_a).to_h
          empty_set_sensors = (set_without_prediction.to_a - non_empty_set_sensors.to_a).to_h

          # Keep correct features, and add them the prediction values that are empty in the set
          empty_set_sensors.keys.each do |feature|
            set_intersect_prediction.merge!(feature => prediction_without_set[feature])
          end

          # Delete keys from sets that have already been used
          set_without_prediction.delete_if { |k, v| v.empty? }
          prediction_without_set.delete_if { |k, v| empty_set_sensors.keys.include?(k) }

          # Take grouped values of remaining difference sets
          distinct_values = []
          keys_used = []

          # Should have same keys at this point
          set_without_prediction.keys.each do |feature|
            distinct_values << [set_without_prediction[feature], prediction_without_set[feature]]
            keys_used << feature
          end

          # Generate combinations
          first = distinct_values.shift

          if first.present?
            generated_combinations = distinct_values.present? ? first.product(*distinct_values) : first.product()

            # For each combination, attach the intersection + prediction replaced features => set_intersect_prediction
            generated_combinations.each do |combination|
              @combinations << Hash[[keys_used, combination].transpose].merge(set_intersect_prediction)
            end
          end
        end
      end
    end
  end
end
