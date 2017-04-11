require 'csv'

module Ap
  module FormatGenerators
    class ImportCsv
      def initialize(environment, plant)
        @path = "#{Rails.root}/public/imports/#{environment}_#{plant}.csv"
        @plant = plant
        @environment = environment
      end

      def perform
        import_csv_data
      end

      private

      def creator
        Ap::CreatorsModifiers::PredictionCreation.new(@params).perform
      end

      def import_csv_data
        sheet = CSV.parse(File.open(@path))
        header = sheet[0]

        (1...sheet.length).each do |i| # file contains \n at EOF
          @params = { prediction_type: 'simulation', plant_selection: 'plant' }
          row =  Hash[[header, sheet[i]].transpose].symbolize_keys
          @params.merge!(row)

          creator
        end
      end

    end
  end
end
