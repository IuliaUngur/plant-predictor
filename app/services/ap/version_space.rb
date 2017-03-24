module Ap
  class VersionSpace
    # valid results: plant survives, plant dies, uncertain outcome

    def initialize(prediction)
      @prediction_to_analyze = prediction
      @predictions = Prediction
        .predictions_with_sensors(@prediction_to_analyze.environment)
        .where.not(result: nil)
        .distinct
        .reverse
    end

    def perform
      # ensure that first example is positive
      return 'plant survives' if @predictions.count.zero?

      hypotheses = Ap::HypothesesSets.new(@predictions)
      sets = hypotheses.analyze
      @G = sets[:general]
      @S = sets[:specific]

      create_hypotheses_JSON_file
      prediction_outcome
    end

    private

    def create_hypotheses_JSON_file
      version_space = {}

      File.open("public/#{@prediction_to_analyze.environment}_hypotheses.json", 'w') do |f|
        version_space[:general] = Hash[@G.map.with_index.to_a].invert
        version_space[:specific] = Hash[@S.map.with_index.to_a].invert
        # version_space[:uncertain] = Hash[@U.map.with_index.to_a].invert

        f.puts JSON.pretty_generate(version_space)
      end
    end

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
        @prediction_to_analyze.sensors.each do |sensor|
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
