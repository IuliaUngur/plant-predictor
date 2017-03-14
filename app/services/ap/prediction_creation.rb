module Ap
  class PredictionCreation
    def initialize(params)
      @params = params
    end

    def perform
      create_sensors

      return false if @prediction.blank?
      version_space
    end

    def prediction_sensors_with_result
      @prediction.sensor_result_set
    end

    private

    def version_space
      result = Ap::VersionSpace.new(@prediction).perform
      @prediction.update_attribute(:result, result)
    end

    def create_sensors
      ActiveRecord::Base.transaction do
        @prediction = Prediction.create(environment: @params.delete(:prediction_type))

        @params.each do |key, value|
          Ap::SensorCreation.new(key, value, @prediction).perform
        end
      end
    end
  end
end
