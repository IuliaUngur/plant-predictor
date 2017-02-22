module Ap
  class VersionCreation
    # temp - degrees C - float
    # light - "DARK", "MOONLIGHT", "FOG", "CLEAR", "SUNNY"
    # vibrations - value - float
    # distance - value - float
    # humidity - procentage - float/int 0-100
    # rain - "DRY", "CONDENSE", "DRIZZLE", "HEAVY RAIN", "FLOOD"

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
        @prediction = Prediction.create(environment: @params[:prediction_type])
        @params.each do |key, value|
          Sensor.create!(
            name: key,
            measurement: value.to_i.zero? ? "limited" : "continuous",
            value: value,
            prediction_id: @prediction.id
          )
        end
      end
    end
  end
end
