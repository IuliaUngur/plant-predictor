# call: rake ENVIRONMENT=X PLANT=X export_csv

desc 'Export predictions to csv'
task export_csv: :environment do
  environment = (ENV['ENVIRONMENT'] || 'simulation')
  plant = (ENV['PLANT'] || 'plant')

  puts "env= #{environment}, plant=#{plant}"
  Ap::FormatGenerators::ExportCsv.new(environment, plant).perform
end
