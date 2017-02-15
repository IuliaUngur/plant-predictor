module Ap
  class VersionCreation
    # temp - degrees C - float
    # light - "DARK", "MOONLIGHT", "FOG", "CLEAR", "SUNNY"
    # vibrations - value - float
    # distance - value - float
    # humidity - procentage - float/int 0-100
    # rain - "DRY", "CONDENSE", "DRIZZLE", "HEAVY RAIN", "FLOOD"

    def initialize(params, prediction)
      @params = params
      @prediction = prediction
    end

    def perform
      true
    end

    def predictions
      []
    end

    def error
      'Could not create set'
    end
  end
end
