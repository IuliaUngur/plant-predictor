class SensorWriter < ActiveJob::Base
  def perform
    writing_JSON_file
  end

  private

  def writing_JSON_file
    sensor_values = {
      temperature: TEMPERATURE.sample,
      light: LIGHT.sample,
      vibration: rand(1000).to_s,
      distance: DISTANCE.sample,
      humidity: rand(100).to_s,
      raindrop: RAINDROP.sample
    }

    File.open("public/sensor_readings.json", 'w') do |f|
      f.puts JSON.pretty_generate(sensor_values)
    end
  end
end
