module Ap
  module Algorithm
    class UncertainOutcomes
      def initialize(general_set, specific_set, prediction, empty_slot)
        @G = general_set
        @S = specific_set
        @prediction = prediction
        @empty_slot = empty_slot

        @combinations = {}
        @absent = []
        @different = []
      end

      def generate
        # [WIP]

        # TODO: generate all combinations from :
        #     values that are not mentioned in S
        #     and values that are in G
        # eg: G = {temp = cold}, S={light = dark, temp=cold, humid = high}
        #     not_in_S={distance, raindrop, vibration}
        #     U = {Combinations of( temp= cold, all(distance), all(raindrop), all(vibration))}

        # #########################################################################

        # Extract values that are not mentioned in S (absent or different)
        generate_absent_different_values

        if @G == [@empty_slot]
          # If G is empty, generate posibilities to fill S with the given prediction
          combinations_on_specific
        else
          # If G is not empty, take absent/different values from S and generate combinations from
          # G with values given from prediction where S values are missing
          combinations_on_general
        end

        # Assign those combinations values of truth based on average of other prediction values where
        # the plant survived 100%
        # if = 100% ok, if > 150% dies if < 50% dies, in between ok
        # eg: if average on temp is 25, and prediction is with 10 => 25 * 100 / 10
        #       => 250% => 250-150 = 100 (and anything above) dies 100%
        #     if average on humid is 30, and prediction is with 25 => 25 * 100 / 30 =>
        #       => 83% => 50% < 83% < 150% => 83-50 = 23% survives with 23%
        #     final value of uncertain rule is based on voting: greatest on average wins =>
        #       => max(avg(dies), avg(survives)) => 100% dies

        find_needed_averages
        assign_truth_levels

        # Return Uncertain Set <Placeholder>
        @U = [@empty_slot]
      end

      private

      def generate_absent_different_values
        @S.each do |hypothesis|
          hypothesis.each do |input|
            # input = [name, value]
            sensor = @prediction.sensors.find_by(name: input.first)

            if input.last.empty?
              @absent << input.first.to_s if input.last.empty?
            else
              @different << [sensor.name.to_sym, sensor.value] if sensor.value != input.last
            end
          end
        end
      end

      def combinations_on_specific
        # format on different eg:

        #   @different = [[:temperature, "COOL"], [:distance, "CLOSE"], [:humidity, "11"]]
        #   @S.first = {:light=>"DARK", :temperature=>"HOT", :distance=>"NEARBY", :raindrop=>"DRY", :humidity=>"33", :vibration=>"33"}

        #   keys conflict = [:temperature, :distance, :humidity]
        #   exclude conflict keys from S=> new_s = {:light=>"DARK", :raindrop=>"DRY", :vibration=>"33"}
        #   the 2 arrays to create combinations from: new_s.to_a and @different


        if @absent.empty? and @different.present?
          @S.each do |h|
            only_specific = h

            common_keys = h.keys - @different.to_h.keys
            set_keys = h.keys - common_keys
            set_keys.each { |key| only_specific.except!(key) }

            create_combinations(only_specific, @different)
          end
        end

      end

      def combinations_on_general

      end

      def find_needed_averages

      end

      def assign_truth_levels

      end

      def create_combinations(a, b)

      end
    end
  end
end
