module PredictionHelper
  def active_simulation
    current_page?(simulation_predictions_path) ? 'active' : ''
  end

  def active_live_prediction
    current_page?(live_prediction_predictions_path) ? 'active' : ''
  end

  def active_information
    current_page?(component_information_path) ? 'active' : ''
  end

  def components_paths
    {
      temperature: asset_path('sensors/temperature.png'),
      raindrops: asset_path('sensors/raindrops.png'),
      light: asset_path('sensors/light.png'),
      humidity: asset_path('sensors/humidity.png'),
      distance: asset_path('sensors/distance.png'),
      vibration: asset_path('sensors/vibration.png')
    }
  end

  def icons_paths
    {
      temperature: asset_path('sensor_icons/temperature.png'),
      raindrops: asset_path('sensor_icons/raindrops.png'),
      light: asset_path('sensor_icons/light.png'),
      humidity: asset_path('sensor_icons/humidity.png'),
      distance: asset_path('sensor_icons/distance.png'),
      vibration: asset_path('sensor_icons/vibration.png')
    }
  end

  def components_descriptions
    {
      temperature: "measures the temperature. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      raindrops: "measures the raindrops. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      light: "measures the light. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      humidity: "measures the humidity. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      distance: "measures the distance. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      vibration: "measures the vibration. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis."
    }
  end

  def sensor_constant_values
    {
      raindrop: %w(DRY CONDENSE DRIZZLE HEAVY-RAIN FLOOD),
      light: %w(DARK MOONLIGHT FOG CLEAR SUNNY)
    }
  end
end
