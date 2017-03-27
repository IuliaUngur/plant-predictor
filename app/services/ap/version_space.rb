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

      @empty_slot = {
        light: '', temperature: '', distance: '', raindrop: '', humidity: '', vibration: ''
      }
    end

    def perform
      # ensure that first example is positive
      return 'plant survives' if @predictions.count.zero?

      hypotheses = Ap::HypothesesSets.new(@predictions)
      sets = hypotheses.analyze
      @G = sets[:general]
      @S = sets[:specific]

      @U = Ap::UncertainOutcomes.new(@G, @S).generate

      create_hypotheses_JSON_file
      prediction_outcome
    end

    private

    def create_hypotheses_JSON_file
      version_space = {}

      File.open("public/#{@prediction_to_analyze.environment}_hypotheses.json", 'w') do |f|
        version_space[:general] = Hash[@G.map.with_index.to_a].invert
        version_space[:specific] = Hash[@S.map.with_index.to_a].invert
        version_space[:uncertain] = Hash[@U.map.with_index.to_a].invert if @U != [@empty_slot]

        f.puts JSON.pretty_generate(version_space)
      end
    end

    def prediction_outcome
      Ap::AnalyzeOutcome.new(@G, @S, @U, @prediction_to_analyze).perform
    end

  end
end
