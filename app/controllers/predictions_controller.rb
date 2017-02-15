class PredictionsController < ApplicationController
  def simulation
    @predictions = predictions_with_sensors("simulation")
    @id = prediction_access_id("simulation")
  end

  def live_prediction
    @predictions = predictions_with_sensors("live")
    @id = prediction_access_id("live")
  end

  def create
    creator = Ap::VersionCreation.new(creation_params, "simulation")

    if creator.perform
      render json: { success: creator.prediction_sensors_with_result }, status: 200
    else
      render json: { error: "Could not create set" }, status: 400
    end
  end

  def destroy
    return render json: {
      error: "Not allowed to destroy simulation out of context"
    }, status: 400 if params[:prediction_type] != "simulation"

    predictions = Prediction.predictions_with_sensors("simulation").distinct

    if predictions.destroy_all
      render json: { success: [] }, status: 200
    else
      render json: { error: "Could not delete all simulation predictions" }, status: 400
    end
  end

  private

  def creation_params
    params.permit(:light, :temperature, :vibration, :humidity, :raindrop, :distance)
  end

  def prediction_access_id(environment)
    # needed for access on ajax requests
    Prediction.predictions_without_sensors(environment).first.id
  end

  def predictions_with_sensors(environment)
    predictions = Prediction.predictions_with_sensors(environment).distinct

    predictions.map do |prediction|
      p = {}
      prediction.sensors.map do |sensor|
        p.merge!(sensor.name => sensor.value)
      end
      p.merge!(result: prediction.result.to_s)
    end
  end
end
