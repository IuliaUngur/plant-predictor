module Ap
  class VersionSpace
    # valid results: plant survives, plant dies, uncertain outcome

    def initialize(prediction)
      @prediction = prediction
      @predictions = Prediction
        .predictions_with_sensors(@prediction.environment)
        .where.not(result: nil)
        .distinct
    end

    def perform
      # ensure that first example is positive
      return 'plant survives' if @predictions.count.zero?

      initialize_sets
      analyze_data
      prediction_outcome
    end

    private

    def initialize_sets
      # H - hypothesis set/ all predictions analyze_data

      # G - maximal general hypotheses in H
      @G = {
        light: '',
        temperature: '',
        distance: '',
        raindrop: '',
        humidity: '',
        vibration: ''
      }

      # find first positive example

      # given that the predictions are already ordered by created_at descending
      # a reverse is applied to get the first prediction
      first_set = @predictions.reverse.first.sensors

      # S - maximal specific hypotheses in H
      @S = {
        light: first_set.find_by(name: 'light').value,
        temperature: first_set.find_by(name: 'temperature').value,
        distance: first_set.find_by(name: 'distance').value,
        raindrop: first_set.find_by(name: 'raindrop').value,
        humidity: first_set.find_by(name: 'humidity').value,
        vibration: first_set.find_by(name: 'vibration').value
      }
    end

    def analyze_data
      @predictions.reverse.each do |prediction|
        if prediction.result == "plant survives"

        elsif prediction.result == "plant dies"

        end
      end
    end

    def prediction_outcome
      'plant dies'
    end
  end
end
