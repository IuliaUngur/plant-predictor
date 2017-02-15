module PredictionHelper
  def active_simulation
    current_page?(simulation_predictions_path) ? 'active' : ''
  end

  def active_live_prediction
    current_page?(live_prediction_predictions_path) ? 'active' : ''
  end

  def sensor_paths
    {
      temperature: asset_path('sensor_temperature.png'),
      raindrops: asset_path('sensor_raindrops.png'),
      light: asset_path('sensor_light.png'),
      humidity: asset_path('sensor_humidity.png'),
      distance: asset_path('sensor_distance.png'),
      vibration: asset_path('sensor_vibration.png')
    }
  end

  def sensor_constant_values
    {
      raindrop: %w(DRY CONDENSE DRIZZLE HEAVY-RAIN FLOOD),
      light: %w(DARK MOONLIGHT FOG CLEAR SUNNY)
    }
  end
end
