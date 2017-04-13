# call: rake FILE='file_name' fselector

desc 'Fselector values on data'
task fselector: :environment do
  file = (ENV['FILE'] || 'simulation_plant')

  puts "file= #{file}"
  test_fselect(file)
end

def test_fselect(file)
  puts "\n>============> #{File.basename(__FILE__)}"
  r = FSelector::IG.new

  name2type = {
      :light => :string,
      :temperature => :string,
      :vibration => :numeric,
      :humidity => :numeric,
      :raindrop => :string,
      :distance => :string
  }

  r.data_from_csv("public/exports/#{file}.csv", feature_name2type: name2type)
  puts "  number of samples read: %d" % r.get_sample_size

  puts '  # features: ' + r.get_features.size.to_s

  puts '  Scores '
  puts "  IG(light) = #{r.get_feature_scores[:light][:BEST]}"
  puts "  IG(temperature) = #{r.get_feature_scores[:temperature][:BEST]}"
  puts "  IG(vibration) = #{r.get_feature_scores[:vibration][:BEST]}"
  puts "  IG(humidity) = #{r.get_feature_scores[:humidity][:BEST]}"
  puts "  IG(raindrop) = #{r.get_feature_scores[:raindrop][:BEST]}"
  puts "  IG(distance) = #{r.get_feature_scores[:distance][:BEST]}"


  puts '  Ranks'
  puts "  IG(light) = #{r.get_feature_ranks[:light]}"
  puts "  IG(temperature) = #{r.get_feature_ranks[:temperature]}"
  puts "  IG(vibration) = #{r.get_feature_ranks[:vibration]}"
  puts "  IG(humidity) = #{r.get_feature_ranks[:humidity]}"
  puts "  IG(raindrop) = #{r.get_feature_ranks[:raindrop]}"
  puts "  IG(distance) = #{r.get_feature_ranks[:distance]}"
  puts "<============< #{File.basename(__FILE__)}"
end
