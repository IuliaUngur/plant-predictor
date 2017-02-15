module Ap
  class SimulatorDestruction
    def initialize(prediction)
      @prediction = prediction
    end

    def perform
      true
    end

    def predictions
      []
    end

    def error

    end
  end
end
