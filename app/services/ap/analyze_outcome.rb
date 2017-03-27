module Ap
  class AnalyzeOutcome
    def initialize(general_set, specific_set, uncertain_set, prediction)
      @G = general_set
      @S = specific_set
      @U = uncertain_set

      @prediction = prediction
    end

    def perform
      prediction_outcome
    end

    private

    def prediction_outcome

      matches_S = levels_of_matching(@S)
      matches_G = levels_of_matching(@G)

      # TODO: remove option of G empty and S being fine
      # eg1: G empty 100% , S low => plant dies
      # eg2: G empty 100% , S high => plant survives

      # TODO: generate every rule that is uncertain and include it to version_space JSON
      # ie: every value from the prediction that is not in S or is empty,
      #     but the prediction matches one or more hypotheses from G
      # eg: G = {temp = cold}, S={light = dark, temp=cold, humid = high}
      #     U = {temp=cold & dist=low => 70% survival, temp=cold & dist=high => 30% death } <= decide on highest bidder
      #     compare them with initial survival conditions (or with an average on survival to make vote values)

      if matches_S > 65 and matches_G == 100
        'plant survives S:' + matches_S.to_s + ', G:' + matches_G.to_s
      elsif matches_S < 65 and matches_G != 100
        'plant dies S:' + matches_S.to_s + ', G:' + matches_G.to_s
      else
        'uncertain S:' + matches_S.to_s + ', G:' + matches_G.to_s
      end
    end

    def levels_of_matching(set)
      matches = 0;
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
