module Ap
  class VersionSpace
    # valid results: plant survives, plant dies, uncertain outcome

    def initialize(prediction)
      @prediction = prediction
    end

    def perform
      'plant dies'
    end
  end
end
