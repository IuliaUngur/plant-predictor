### Explanations
  # 1. extract average values from predictions where plant survives
  # 2. extract scores of each attribute in predictions
  # 3. generate combinations of values from S or G
  #       => S = T1,L1,H1 , Prediction = T2,L2,H2,V2,D2,R2
  #       1. T1,L1,H1,V2,D2,R2; 2. T1,L1,H2,V2,D2,R2; 3. T1,L2,H2,V2,D2,R2;
  # 4. grades on average values (with scores from fselector)
  # 5. grades on combinations (with scores from fselector)
  # 6. compare each combination score with avg score
        # <50 dies, >50 survives, 50 - uncertain
        # eg: if average on temp is 25, and prediction is with 10 => 10 * 100 / 25
        #       => 40% => 40 < 50 (and anything above) dies 80% (40% * 2)
        #     if average on humid is 30, and prediction is with 25 => 25 * 100 / 30 =>
        #       => 83% => 83% > 50% => 83-50 = 33% => 33 * 2= 66% => survives with 66%

  # 7. final value of uncertain rule is based on voting: greatest on average wins =>
  #     => max(avg(dies), avg(survives)) => 80% dies
###

module Ap
  module UncertainProcessing
    class UncertainOutcomes
      def initialize(general_set, specific_set, prediction_to_analyze, predictions, scores)
        @G = general_set
        @S = specific_set
        @prediction_to_analyze = prediction_to_analyze
        @predictions = predictions
        @scores = scores

        @combinations_result = { dies: [], survives: [], uncertain: [] }
      end

      def perform
        initialize_needed_data
        analyze_prediction
      end

      def values
        @combinations.present? ? @combinations : [EMPTY_SLOT]
      end

      def result
        @result
      end

      private

      def initialize_needed_data
        survival = Ap::UncertainProcessing::AverageSurvivalConditions.new(@predictions)
        @averages = survival.averages_classified

        @combinations = Ap::UncertainProcessing::UncertainCombinations
          .new(@S, @prediction_to_analyze).perform

        @combinations += Ap::UncertainProcessing::UncertainCombinations
          .new(@G, @prediction_to_analyze).perform if @G != [EMPTY_SLOT]
      end

      def analyze_prediction
        @combinations.each do |combination|
          combination.merge!(
            result: levels_of_matching([@averages], combination)
          )
        end

        compare_combinations
        @result = vote_final_value
      end

      def levels_of_matching(set, combination)
        matches = 0
        set.each do |hypothesis|
          EMPTY_SLOT.keys.each do |feature|
            value = combination[feature]

            if value.to_i.zero? || hypothesis[feature] == ""
              matches += 1 if ["", value].include?(hypothesis[feature])
            else
              hypothesis_difference = (hypothesis[feature].to_i - value.to_i).abs
              matches += 1 if
                hypothesis_difference < 0.3 * @scores[feature] * value.to_i
            end
          end
        end

        (matches * 100)/(set.length * 6)
      end

      def compare_combinations
        @combinations.each do |combination|
          if combination[:result] > 50
            @combinations_result[:survives] << combination[:result] # procent out of 100
          elsif combination[:result] < 50
            @combinations_result[:dies] << (50 - combination[:result]) * 2 # procent out of 100
          else
            @combinations_result[:uncertain] << 50
          end
        end
      end

      def vote_final_value
        average_dies = average(@combinations_result[:dies])
        average_survives = average(@combinations_result[:survives])
        average_uncertain = average(@combinations_result[:uncertain].first(1))

        max_result = [average_dies, average_survives].max

        if max_result < average_uncertain
          'uncertain with ' + average_uncertain.to_s + '%'
        elsif max_result == average_dies
          'dies with ' + average_dies.to_s + '%'
        else
          'survives with ' + average_survives.to_s + '%'
        end
      end

      def average(list)
        list.present? ? list.sum / list.size.to_f : 0
      end

    end
  end
end
