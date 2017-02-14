class PredictionsController < ApplicationController
  def simulation
    @title = "Simulation"
  end

  def live_prediction
    @title = "Prediction"
  end

  def create
    return render json: { success: "yes"}, status: 200
  end

  def destroy
  end
end
