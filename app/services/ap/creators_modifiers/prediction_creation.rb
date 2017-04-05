module Ap
  module CreatorsModifiers
    class PredictionCreation
      def initialize(params)
        @params = params
        selection = @params.delete(:plant_selection)
        @plant = selection.present? ? selection + " " : "plant "
        @environment = @params.delete(:prediction_type)
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
        result = Ap::Algorithm::VersionSpace.new(@prediction, @plant).perform
        @prediction.update_attribute(:result, @plant + result)
      end

      def create_sensors
        ActiveRecord::Base.transaction do
          @prediction = Prediction.create(environment: @environment)

          @params.each do |key, value|
            Ap::CreatorsModifiers::SensorCreation.new(key, value, @prediction).perform
          end
        end
      end

    end
  end
end
