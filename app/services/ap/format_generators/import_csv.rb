require 'csv'

module Ap
  module FormatGenerators
    class ImportCsv
      def initialize(environment, plant)
        @path = "#{Rails.root}/public/imports/#{environment}_#{plant}.csv"
        @environment = environment
        @plant = plant
        @header = [:light, :temperature, :vibration, :humidity,
          :raindrop,:distance,:result]
      end

      def perform
        import_csv_data
      end

      private

      def creator
        Ap::CreatorsModifiers::PredictionCreation.new(@params).perform
      end

      def import_csv_data
        CSV.foreach(File.open(@path), headers: false) do |row|
          @params = { prediction_type: @environment, plant_selection: @plant }
          @params.merge!(Hash[[@header, row].transpose])
          creator
        end
      end

    end
  end
end
