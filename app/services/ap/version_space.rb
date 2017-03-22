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

        f.puts JSON.pretty_generate(version_space)
      end
    end

    def prediction_outcome
      matches_S = true
      matches_G = false

      @S.each do |hypothesis|
        @prediction_to_analyze.sensors.each do |sensor|
          matches_S = false if ["", sensor.value].exclude?(hypothesis[sensor.name.to_sym])
        end
      end

      @G.each do |hypothesis|
        @prediction_to_analyze.sensors.each do |sensor|
          matches_G = true if ["", sensor.value].include?(hypothesis[sensor.name.to_sym])
        end
      end

      if matches_S and matches_G
        'plant survives'
      elsif matches_S and !matches_G
        'uncertain outcome'
      else
        'plant dies'
      end
    end

  end
end
