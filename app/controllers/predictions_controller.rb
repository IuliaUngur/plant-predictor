class PredictionsController < ApplicationController
  def simulation
    @predictions = predictions_with_sensors("simulation")
    @id = prediction_access_id("simulation")
  end

  def live_prediction
    @predictions = predictions_with_sensors("live")
    @id = prediction_access_id("live")
  end

  def component_information
  end

  def create
    creator = Ap::PredictionCreation.new(creation_params)

    if creator.perform
      render json: { success: creator.prediction_sensors_with_result }, status: 200
    else
      render json: { error: "Could not create set" }, status: 400
    end
  end

  def update
    result = check_prerequisites
    return render json: { error: result }, status: 400 if result.present?

    prediction = Prediction.find(update_params[:id])

    if prediction.update_attributes(update_params)
      render json: { success: prediction.sensor_result_set }, status: 200
    else
      render json: { error: "Could not update the prediction" }, status: 400
    end
  end

  def destroy
    predictions = Prediction.predictions_with_sensors(params[:prediction_type]).distinct

    if predictions.destroy_all
      render json: { success: [] }, status: 200
    else
      render json: { error: "Could not delete all simulation predictions" }, status: 400
    end
  end

  private

  def creation_params
    params.permit(:light, :temperature, :vibration, :humidity, :raindrop, :distance, :prediction_type)
  end

  def update_params
    params.permit(:result, :id)
  end

  def prediction_access_id(environment)
    # needed for access on ajax requests
    Prediction.predictions_without_sensors(environment).first.id
  end

  def predictions_with_sensors(environment)
    predictions = Prediction.predictions_with_sensors(environment).distinct

    predictions.map { |prediction| prediction.sensor_result_set }
  end

  def check_prerequisites
    return "Result can not be empty" if update_params[:result].empty?

    return "Invalid option. Posible results: \n- plant survives \n- plant dies \n- uncertain outcome" if
      ["plant survives" ,"plant dies", "uncertain outcome"].exclude?(update_params[:result])

    ""
  end
end
