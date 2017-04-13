module Ap
  module Algorithm
    class FselectorFilter
      def initialize(file)
        @file = file
      end

      def perform
        initialize_selector
        process_values
      end

      def scores
        @scores
      end

      def ranks
        @ranks
      end

      private

      def initialize_selector
        @r = FSelector::IG.new

        name2type = {
          light: :string,
          temperature: :string,
          vibration: :numeric,
          humidity: :numeric,
          raindrop: :string,
          distance: :string
        }

        @r.data_from_csv("public/exports/#{@file}.csv", feature_name2type: name2type)
      end

      def process_values
        @scores = empty_features
        @ranks = empty_features

        empty_features.keys.each do |feature|
          @scores[feature] = @r.get_feature_scores[feature][:BEST]
          @ranks[feature] = @r.get_feature_ranks[feature]
        end
      end

      def empty_features
        {
          light: '',
          temperature: '',
          vibration: '',
          humidity: '',
          raindrop: '',
          distance: ''
        }
      end
    end
  end
end
