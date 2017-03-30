module Ap
  module Algorithm
    class UncertainOutcomes
      def initialize(general_set, specific_set, prediction, empty_slot)
        @G = general_set
        @S = specific_set
        @prediction = prediction
        @empty_slot = empty_slot

        @combinations = @empty_slot
        @absent = []
      end

      def generate
        # TODO: generate every rule that is uncertain and include it to version_space JSON
        # ie: every value from the prediction that is not in S or is empty,
        #     but the prediction matches one or more hypotheses from G
        # eg: G = {temp = cold}, S={light = dark, temp=cold, humid = high}
        #     U = {temp=cold & dist=low => 70% survival, temp=cold & dist=high => 30% death } <= decide on highest bidder
        #     compare them with initial survival conditions (or with an average on survival to make vote values)

        # TODO: generate all combinations from :
        #     values that are not mentioned in S
        #     and values that are in G
        # eg: G = {temp = cold}, S={light = dark, temp=cold, humid = high}
        #     not_in_S={distance, raindrop, vibration}
        #     U = {Combinations of( temp= cold, all(distance), all(raindrop), all(vibration))}
        absent_values
        # require 'pry'; binding.pry
        @U = [@empty_slot]
      end

      private

      def absent_values
        @S.each do |hypothesis|
          hypothesis.each do |input|
            # input = [name, value]
            @absent << input.first.to_s.upcase if input.last.empty?
          end
        end
      end

      def create_combinations
        @G.each do |hypothesis|
          #WIP
        end
      end

    end
  end
end
