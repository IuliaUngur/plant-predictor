require 'csv'

module Ap
  module FormatGenerators
    class ExportCsv
      def initialize(environment, plant)
        @predictions = Prediction.predictions_on_plants(environment, plant)
        @path = "#{Rails.root}/public/exports/#{environment}_#{plant}.csv"
      end

      def perform
        csv_generator
      end

      private

      def csv_generator
        CSV.open(@path, "wb") do |csv|
          @predictions.each do |prediction|
            data=[]
            prediction.sensors.each {|sensor| data << sensor.value }
            result = prediction.result.include?("dies") ? "dies" : "survives"
            data << result
            csv << data
          end
        end
      end
    end
  end
end
