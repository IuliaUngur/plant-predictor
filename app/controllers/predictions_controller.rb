class PredictionsController < ApplicationController
  def simulation
    @title = "Simulation"
  end

  def live_prediction
    @title = "Prediction"
  end

  def create
    # prediction: [sensor], alg_outcome
    return render json: { success: []}, status: 200
  end

  def destroy
    return render json: { success: []}, status: 200
  end
end
