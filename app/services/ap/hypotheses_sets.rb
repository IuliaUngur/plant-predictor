module Ap
  class HypothesesSets
    def initialize(predictions)
      @predictions = predictions

      @empty_slot = {
        light: '',
        temperature: '',
        distance: '',
        raindrop: '',
        humidity: '',
        vibration: ''
      }

      initialize_sets
    end

    def analyze
      analyze_data
      { general: @G, specific: @S }
    end

    private

    def initialize_sets
      # H - hypotheses set/ all predictions analyze_data

      # G - maximal general hypotheses in H
      @G = [ @empty_slot ]

      # find first positive example

      # given that the predictions are already ordered by created_at descending
      # a reverse is applied to get the first prediction
      first_set = @predictions.shift.sensors
      @prediction_example_set = @predictions

      # S - maximal specific hypotheses in H
      @S = [
        {
          light: first_set.find_by(name: 'light').value,
          temperature: first_set.find_by(name: 'temperature').value,
          distance: first_set.find_by(name: 'distance').value,
          raindrop: first_set.find_by(name: 'raindrop').value,
          humidity: first_set.find_by(name: 'humidity').value,
          vibration: first_set.find_by(name: 'vibration').value
        }
      ]
    end

    def analyze_data
      # TODO: make network grow - not just 1 layer in depth + refactor code

      @prediction_example_set.each do |prediction|
        if prediction.result.include?("plant survives")

          # Prune G to exclude descriptions inconsistent with the positive example.
          @G.each do |hypothesis|
            prediction.sensors.each do |sensor|
              if hypothesis[sensor.name.to_sym] != sensor.value
                hypothesis[sensor.name.to_sym] = ""
              end
            end
          end

          # Generalize S to include the positive example.
          @S.each do |hypothesis|
            prediction.sensors.each do |sensor|
              if hypothesis[sensor.name.to_sym] != sensor.value
                hypothesis[sensor.name.to_sym] = ""
              end
            end
          end

        elsif prediction.result.include?("plant dies")

          # Specialize G to exclude the negative example
          @S.each do |hypothesis|
            hypothesis.each do |input|
              # input = [name, value]
              if input.last != prediction.sensors.find_by(name: input.first).value
                new_entry = insert_set(input)
                @G << new_entry unless @G.include?(new_entry)
              end
            end
          end

        end

        # Eliminate from G empty case if it contains anything else
        @G.count.times do
          @G.slice!(@G.index(@empty_slot)) if @G.count > 1 and @G.include?(@empty_slot)
        end
      end
    end

    def insert_set(input)
      {
        light: input.first == :light ? input.last : '',
        temperature: input.first == :temperature ? input.last : '',
        distance: input.first == :distance ? input.last : '',
        raindrop: input.first == :raindrop ? input.last : '',
        humidity: input.first == :humidity ? input.last : '',
        vibration: input.first == :vibration ? input.last : ''
      }
    end

  end
end
