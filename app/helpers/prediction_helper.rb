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

  def homepage_paths
    {
      arduino: asset_path('arduino-1.png'),
      react: asset_path('react.png'),
      ruby: asset_path('ruby.png'),
      slideshow1: "https://placehold.it/2048x1020",
      slideshow2: "https://placehold.it/2048x1024",
      slideshow3: "https://placehold.it/2048x1024",
      slideshow4: "https://placehold.it/2048x1024"
    }
  end

  def components_descriptions
    {
      temperature: "Senses the temperature between the range of –40°C and 125°C with an offset of 0.5°C. ",
      raindrops: "measures the raindrops. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      light: "Uses the amount of light detected to determine how much current to pass through the circuit.",
      humidity: "measures the humidity. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      distance: "measures the distance. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis.",
      vibration: "measures the vibration. Lorem ipsum dolor sit amet, vivendo nominavi eu eam. Per id velit primis."
    }
  end

  def components_datasheets
    {
      temperature: "http://www.ti.com/lit/ds/symlink/lm50.pdf",
      raindrops: "https://www.openhacks.com/uploadsproductos/rain_sensor_module.pdf",
      light: "https://www.robofun.ro/docs/ELPT15-21C.pdf",
      humidity: "http://forum.researchdesignlab.com/datasheet/sensors/soil%20moisture%20sensor.pdf",
      distance: "http://www.micropik.com/PDF/HCSR04.pdf",
      vibration: "https://www.sparkfun.com/datasheets/Sensors/Flex/p37e.pdf"
    }
  end

  def sensor_constant_values
    {
      raindrop: %w(DRY CONDENSE DRIZZLE HEAVY-RAIN FLOOD),
      light: %w(DARK MOONLIGHT FOG CLEAR SUNNY)
    }
  end

  def available_plants
    %w(potato beans rice wheat corn)
  end
end
