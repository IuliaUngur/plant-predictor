# call: rake FILE='file_name' fselector

desc 'Fselector values on data'
task fselector: :environment do
  file = (ENV['FILE'] || 'simulation_plant')

  puts "file= #{file}"
  Ap::Algorithm::FselectorFilter.new(file).perform
end
