class PredictionsController < ApplicationController
  include ApplicationHelper

  def simulation
    @predictions = predictions_with_sensors("simulation", "plant")
    @id = prediction_access_id("simulation")
  end

  def live_prediction
    @predictions = predictions_with_sensors("live", "plant")
    @id = prediction_access_id("live")
  end

  def component_information
  end

  def simulation_hypotheses
    render json: File.read('public/simulation_hypotheses.json')
  end

  def live_hypotheses
    render json: File.read('public/live_hypotheses.json')
  end

  def create
    create_sensor_set(permitted_params)
  end

  def update
    errors = check_prerequisites
    return render json: { error: errors }, status: 400 if errors.present?

    prediction = Prediction.find(permitted_params[:id])

    plant = permitted_params[:plant_selection].present? ?
      permitted_params[:plant_selection] + " " : "plant "

    if prediction.update_attribute(:result, plant + permitted_params[:result])
      render json: { success: prediction.sensor_result_set }, status: 200
    else
      render json: { error: "Could not update the prediction" }, status: 400
    end
  end

  def destroy
    predictions = Prediction.predictions_with_sensors(permitted_params[:prediction_type])

    if predictions.destroy_all
      Ap::CreatorsModifiers::EmptyJsonFiles.new(permitted_params[:prediction_type]).perform
      render json: { predictions: [], src: json_files_contents }, status: 200
    else
      render json: { error: "Could not delete all simulation predictions" }, status: 400
    end
  end

  def load_data
    render json: { predictions: predictions_selected, src: json_files_contents }, status: 200
  end

  def reload_predictions
    data = JSON.parse(File.read('public/sensor_readings.json'))
    predictions = Prediction.predictions_on_plants(['live', 'data'], permitted_params[:plant_selection])
    creation_data = data.merge(prediction_type: 'live', plant_selection: permitted_params[:plant_selection])

    fuzzy_data = {}
    data.collect do |k,v| 
      fuzzy_data.merge!(k => Ap::CreatorsModifiers::SensorCreation.new(k, v, nil).get_sensor_value.to_s) 
    end

    return render json: {}, status: 400 if data.values.include?('')
    return create_sensor_set(creation_data) if predictions.empty?

    return render json: {}, status: 400 if 
      predictions.first.sensors.pluck(:name, :value).to_h == fuzzy_data
    create_sensor_set(creation_data)
  end

  private

  def permitted_params
    params.permit(:light, :temperature, :vibration, :humidity, :raindrop, :distance,
      :prediction_type, :plant_selection, :result, :id)
  end

  def prediction_access_id(environment)
    # needed for access on ajax requests
    Prediction.predictions_without_sensors(environment).first.id
  end

  def check_prerequisites
    return "Result can not be empty" if permitted_params[:result].empty?

    return "Invalid option. Posible results: \n- survives \n- dies \n- uncertain" if
      ["survives" ,"dies", "uncertain"].exclude?(permitted_params[:result])

    ""
  end

  def json_files_contents
    {
      simulation: json_read(simulation_hypotheses_path),
      live: json_read(live_hypotheses_path),
      readings: json_read(sensor_readings_path)
    }
  end

  def predictions_selected
    selection = permitted_params[:plant_selection].empty? ? "plant": permitted_params[:plant_selection]
    predictions_with_sensors([permitted_params[:prediction_type], "data"], selection)
  end

  def predictions_with_sensors(environment, plant)
    predictions = Prediction.predictions_on_plants(environment, plant)
    predictions.map { |prediction| prediction.sensor_result_set }
  end

  def create_sensor_set(data)
    creator = Ap::CreatorsModifiers::PredictionCreation.new(data)

    if creator.perform
      render json: {
        predictions: creator.prediction_sensors_with_result,
        src: json_files_contents
      }, status: 200
    else
      render json: { error: "Could not create set" }, status: 400
    end
  end
end
