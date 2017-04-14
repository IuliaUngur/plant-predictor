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
  module Algorithm
    class UncertainOutcomes
      def initialize(general_set, specific_set, prediction_to_analyze, predictions, empty_slot)
        @G = general_set
        @S = specific_set
        @prediction_to_analyze = prediction_to_analyze
        @predictions = predictions
        @empty_slot = empty_slot

        @combinations = {}
        @combinations_result = { dies: [], survives: [] }
        @absent = []
        @different = []

        @average_survival = empty_slot
      end

      def perform
        analyze_prediction
      end

      def values
        @U
      end

      def result
        @result
      end

      private

      def analyze_prediction
        average_survival_conditions
        attribute_learning_scores

        if @G == [@empty_slot]
          generate_combinations(@S)
        else
          generate_combinations(@G)
        end

        @average_survival = grade_set(@average_survival)
        grade_combinations

        assign_procentages
        compare_combinations

        @result = vote_final_value
      end

      def average_survival_conditions
        survival_predictions = @predictions.where('result LIKE ?', '%survives%')
        no_survivals = survival_predictions.count

        survival_predictions.each do |prediction|
          prediction.sensors.each do |sensor|
            # careful on average for string values
            @average_survival[sensor.name.to_sym] += (sensor.value / no_survivals)
          end
        end
      end

      def attribute_learning_scores
        plant_name = @predictions.first.result.split.first
        file = @predictions.first.environment + '_' + plant_name

        fselector = Ap::Algorithm::FselectorFilter.new(file)
        fselector.perform

        @scores = fselector.scores
      end

      # TODO
      def generate_combinations(set)
        set.each do |hypotheses|

        end
      end

      def grade_combinations
        @combinations.each do |combination|
          combination = grade_set(combination)
        end
      end

      def grade_set(set)
        @empty_slot.keys.each do |attribute|
          set[attribute] *= @scores[attribute]
        end
      end

      def assign_procentages
        @combinations.each do |combination|
          sum = 0
          @empty_slot.keys.each do |attribute|
            sum += (combination[attribute] * 100 / @average_survival[attribute])
          end
          combination[:result] = sum
        end
      end

      def compare_combinations
        @combinations.each do |combination|
          if combination[:result] < 50
            @combinations_result[:dies] << combination[:result] * 2 # procent out of 100
          else
            @combinations_result[:survival] << (50 - combination[:result]) * 2 # procent out of 100
          end
        end
      end

      def vote_final_value
        average_dies = average(@combinations_result[:dies])
        average_survives = average(@combinations_result[:survival])

        if [average_dies, average_survives].max == average_dies
          'dies with ' + average_dies.to_s + '%'
        else
          'survives with ' + average_survives.to_s + '%'
        end
      end

      def average(list)
        list.sum / list.size.to_f
      end
    end
  end
end
