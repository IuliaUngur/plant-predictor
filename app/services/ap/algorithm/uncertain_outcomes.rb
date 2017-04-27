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
      def initialize(general_set, specific_set, prediction_to_analyze, predictions, scores)
        @G = general_set
        @S = specific_set
        @prediction_to_analyze = prediction_to_analyze
        @predictions = predictions
        @scores = scores

        @combinations_result = { dies: [], survives: [] }
        @average_survival = {
          light: 0.0,
          temperature: 0.0,
          distance: 0.0,
          raindrop: 0.0,
          humidity: 0.0,
          vibration: 0.0
        }
      end

      def perform
        # analyze_prediction
      end

      def values
        [EMPTY_SLOT]
      end

      def result
        # @result
        'uncertain'
      end

      private

      def analyze_prediction
        average_survival_conditions

        if @G == [EMPTY_SLOT]
          @combinations = Ap::Algorithm::UncertainCombinations.new(@S,@prediction_to_analyze).perform
        else
          @combinations = Ap::Algorithm::UncertainCombinations.new(@G,@prediction_to_analyze).perform
        end

        require 'pry'; binding.pry

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
            if sensor.value.to_i.zero?
              sensor_constant_values = sensor.name.to_s.upcase.constantize
              @average_survival[sensor.name.to_sym] +=
                (sensor_constant_values.find_index(sensor.value).to_f / no_survivals)
            else
              @average_survival[sensor.name.to_sym] += (sensor.value.to_f / no_survivals)
            end
          end
        end

        # average_survival needed as is for calculating procentages
        @avg_classified_values = @average_survival.clone
        convert_to_classes(@avg_classified_values)
      end

      def grade_combinations
        @combinations.each do |combination|
          combination = grade_set(combination)
        end
      end

      def grade_set(set)
        EMPTY_SLOT.keys.each do |attribute|
          set[attribute] *= @scores[attribute]
        end
      end

      def assign_procentages
        @combinations.each do |combination|
          sum = 0
          EMPTY_SLOT.keys.each do |attribute|
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


      ############

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
