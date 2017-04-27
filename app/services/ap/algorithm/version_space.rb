module Ap
  module Algorithm
    class VersionSpace
      # valid results: plant survives, plant dies, uncertain outcome

      def initialize(prediction, plant)
        @prediction_to_analyze = prediction
        @predictions = Prediction.predictions_on_plants([@prediction_to_analyze.environment, 'data'], plant)
      end

      def perform
        # ensure that first example is positive
        return 'survives' if @predictions.count.zero?

        generate_hypotheses_sets
        prediction_outcome
        create_hypotheses_JSON_file

        @result
      end

      private

      def generate_hypotheses_sets
        hypotheses = Ap::Algorithm::HypothesesSets.new(@predictions)
        sets = hypotheses.analyze
        @G = sets[:general]
        @S = sets[:specific]
      end

      def prediction_outcome
        analyzer = Ap::Algorithm::AnalyzeOutcome.new(@G, @S, @prediction_to_analyze, @predictions)
        @result = analyzer.perform
        @U = analyzer.uncertain_set
      end

      def create_hypotheses_JSON_file
        version_space = {}

        File.open("public/#{@prediction_to_analyze.environment}_hypotheses.json", 'w') do |f|
          version_space[:general] = Hash[@G.map.with_index.to_a].invert
          version_space[:specific] = Hash[@S.map.with_index.to_a].invert
          version_space[:uncertain] = Hash[@U.map.with_index.to_a].invert if @U != [EMPTY_SLOT]

          f.puts JSON.pretty_generate(version_space)
        end
      end
    end
  end
end
