module Ap
  module Algorithm
    class AnalyzeOutcome
      def initialize(general_set, specific_set, prediction_to_analyze, predictions, plant)
        @G = general_set
        @S = specific_set

        @prediction_to_analyze = prediction_to_analyze
        @predictions = predictions

        @plant = plant
      end

      def perform
        generate_scores
        @matches_S = levels_of_matching(@S)
        @matches_G = levels_of_matching(@G)

        prediction_outcome
      end

      def uncertain_set
        @U.present? ? @U : [EMPTY_SLOT]
      end

      private

      def generate_scores
        file_env = @prediction_to_analyze.environment + '_' + @plant
        file_data = 'data_' + @plant

        Ap::FormatGenerators::ExportCsv.new(@prediction_to_analyze.environment, @plant).perform
        Ap::FormatGenerators::ExportCsv.new('data', @plant).perform

        fselector_env = Ap::Algorithm::FselectorFilter.new(file_env)
        fselector_env.perform

        fselector_data = Ap::Algorithm::FselectorFilter.new(file_data)
        fselector_data.perform

        @scores = fselector_env.scores.merge(fselector_data.scores){ |k, a_value, b_value| (a_value + b_value)/2 }
      end

      def levels_of_matching(set)
        matches = 0
        set.each do |hypothesis|
          @prediction_to_analyze.sensors.each do |sensor|
            sensor_name = sensor.name.to_sym
            if sensor.value.to_i.zero? || hypothesis[sensor_name] == ""
              matches += 1 if ["", sensor.value].include?(hypothesis[sensor_name])
            else
              hypothesis_difference = (hypothesis[sensor_name].to_i - sensor.value.to_i).abs
              matches += 1 if
                hypothesis_difference < 0.3 * @scores[sensor_name] * sensor.value.to_i
            end
          end
        end

        (matches * 100)/(set.length * 6)
      end

      def prediction_outcome
        return compare_matches(true, true) if @G == [EMPTY_SLOT]

        outcome = compare_matches(@matches_G == 100, @matches_G != 100)
        outcome + ', G:' + @matches_G.to_s
      end

      def compare_matches(general_survive_evaluation, general_death_evaluation)
        if @matches_S > 65 and general_survive_evaluation
          'survives S:' + @matches_S.to_s
        elsif @matches_S < 45 and general_death_evaluation
          'dies S:' + @matches_S.to_s
        else
          uncertain = Ap::UncertainProcessing::UncertainOutcomes.new(
            @G, @S, @prediction_to_analyze, @predictions, @scores
          )

          uncertain.perform

          @U = uncertain.values
          uncertain.result
        end
      end

    end
  end
end
