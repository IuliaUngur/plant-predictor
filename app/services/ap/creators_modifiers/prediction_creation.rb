module Ap
  module CreatorsModifiers
    class PredictionCreation
      def initialize(params)
        @params = params
        @environment = @params.delete(:prediction_type)
        @result = @params.delete(:result)
        selection = @params.delete(:plant_selection)

        @plant = selection.present? ? selection + " " : "plant "
      end

      def perform
        create_sensors

        return false if @prediction.blank?
        return update(@plant + @result) if @result.present?

        version_space
      end

      def prediction_sensors_with_result
        @prediction.sensor_result_set
      end

      private

      def version_space
        algorithm_result = Ap::Algorithm::VersionSpace.new(@prediction, @plant).perform
        update(@plant + algorithm_result)
      end

      def update(result)
        @prediction.update_attribute(:result, result)
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
