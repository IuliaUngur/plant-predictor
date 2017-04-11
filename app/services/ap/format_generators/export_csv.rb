require 'csv'

module Ap
  module FormatGenerators
    class ExportCsv
      def initialize(environment, plant)
        @predictions = Prediction.predictions_on_plants(environment, plant)
        @plant = plant
        @environment = environment
        @path = "#{Rails.root}/public/exports/#{@environment}_#{@plant}.csv"
      end

      def perform
        csv_generator
      end

      private

      def csv_generator(options = {})
        CSV.open(@path, "wb") do |csv|
          csv << ["light", "temperature", "vibration",
            "humidity", "raindrop", "distance", "result"]

          @predictions.each do |prediction|
            data=[]
            prediction.sensors.each {|sensor| data << sensor.value }
            data << prediction.result
            csv << data
          end
        end
      end
    end
  end
end
