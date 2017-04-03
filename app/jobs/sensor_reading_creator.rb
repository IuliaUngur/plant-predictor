class SensorReadingCreator < ActiveJob::Base
  def perform
    readings_JSON_file
  end

  private

  def readings_JSON_file
    sensor_readings = {
      temperature: Ap::Fuzzy::SensorValues::TEMPERATURE.sample,
      light: Ap::Fuzzy::SensorValues::LIGHT.sample,
      vibration: rand(1024).to_s,
      distance: Ap::Fuzzy::SensorValues::DISTANCE.sample,
      humidity: rand(1024).to_s,
      raindrop: Ap::Fuzzy::SensorValues::RAINDROP.sample
    }

    File.open("public/sensor_readings.json", 'w') do |f|
      f.puts JSON.pretty_generate(sensor_readings)
    end
  end
end
