# call: rake ENVIRONMENT=X PLANT=X import_csv

desc 'Import predictions to csv'
task import_csv: :environment do
  environment = (ENV['ENVIRONMENT'] || 'simulation')
  plant = (ENV['PLANT'] || 'plant')

  puts "env= #{environment}, plant=#{plant}"
  Ap::FormatGenerators::ImportCsv.new(environment, plant).perform
end
