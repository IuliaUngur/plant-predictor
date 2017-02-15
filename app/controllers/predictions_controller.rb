class PredictionsController < ApplicationController
  def simulation
    @prediction = Prediction.find_or_create_by(result: false, environment: "simulation")
  end

  def live_prediction
    @prediction = Prediction.find_or_create_by(result: false, environment: "live")
  end

  def create
    creator = Ap::VersionCreation.new(params, @prediction)

    if creator.perform
      render json: { success: creator.predictions }, status: 200
    else
      render json: { error: creator.error }, statur: 400
    end
  end

  def destroy
    return render json: {
      error: "Not allowed to destroy simulation out of context"
    }, status: 400 if params[:prediction_type] != "simulation"

    destroyer = Ap::SimulatorDestruction.new(@prediction)

    if destroyer.perform
      render json: { success: destroyer.predictions }, status: 200
    else
      render json: { error: destroyer.error }, status: 400
    end
  end
end
