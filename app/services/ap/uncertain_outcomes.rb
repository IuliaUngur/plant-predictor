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
    end

    def generate
      @U = [@empty_slot]
    end

  end
end
