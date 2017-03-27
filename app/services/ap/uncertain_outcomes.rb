module Ap
  class UncertainOutcomes
    def initialize(general_set, specific_set)
      @G = general_set
      @S = specific_set

      @empty_slot = {
        light: '',
        temperature: '',
        distance: '',
        raindrop: '',
        humidity: '',
        vibration: ''
      }
      @combinations = @empty_slot
      @absent = []
    end

    def generate
      # TODO: generate all combinations from :
      #     values that are not mentioned in S
      #     and values that are in G
      # eg: G = {temp = cold}, S={light = dark, temp=cold, humid = high}
      #     not_in_S={distance, raindrop, vibration}
      #     U = {Combinations of( temp= cold, all(distance), all(raindrop), all(vibration))}

      @U = [@empty_slot]
    end

    private

    def absent_values
      @S.each do |hypothesis|
        hypothesis.each do |input|
          # input = [name, value]
          @absent << input.first.upper if input.last.empty?
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
