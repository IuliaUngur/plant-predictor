class SensorsController < ApplicationController
  def create
  end

  def destroy
  end

  def sensor_readings
    render json: File.read('public/sensor_readings.json')
  end
end
