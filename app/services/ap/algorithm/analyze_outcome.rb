module Ap
  module Algorithm
    class AnalyzeOutcome
      def initialize(general_set, specific_set, prediction, empty_slot)
        @G = general_set
        @S = specific_set

        @prediction = prediction
        @empty_slot = empty_slot
      end

      def perform
        @matches_S = levels_of_matching(@S)
        @matches_G = levels_of_matching(@G)

        prediction_outcome
      end

      def uncertain_set
        @U if @U.present?
        [@empty_slot]
      end

      private

      def prediction_outcome
        return compare_matches(true, true) if @G == [@empty_slot]

        outcome = compare_matches(@matches_G == 100, @matches_G != 100)
        outcome + ', G:' + @matches_G.to_s
      end

      def compare_matches(general_survive_evaluation, general_death_evaluation)
        if @matches_S > 65 and general_survive_evaluation
          'plant survives S:' + @matches_S.to_s
        elsif @matches_S < 45 and general_death_evaluation
          'plant dies S:' + @matches_S.to_s
        else
          # generate only if we have uncertainty
          @U = Ap::Algorithm::UncertainOutcomes.new(@G, @S, @prediction, @empty_slot).generate

          #TODO: analyze here @U - uncertain set
          'uncertain S:' + @matches_S.to_s
        end
      end

      def levels_of_matching(set)
        matches = 0
        set.each do |hypothesis|
          @prediction.sensors.each do |sensor|
            if sensor.value.to_i.zero? || hypothesis[sensor.name.to_sym] == ""
              matches += 1 if ["", sensor.value].include?(hypothesis[sensor.name.to_sym])
            else
              matches += 1 if (hypothesis[sensor.name.to_sym].to_i - sensor.value.to_i).abs < 0.3 * sensor.value.to_i
            end
          end
        end

        (matches * 100)/(set.length * 6)
      end

    end
  end
end
