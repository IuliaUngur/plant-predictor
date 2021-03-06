module Ap
  module Algorithm
    class HypothesesSets
      def initialize(predictions)
        @predictions = predictions

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
        @G = [ EMPTY_SLOT ]

        # find first positive example

        # given that the predictions are already ordered by created_at descending
        # a reverse is applied to get the first prediction
        first_set = @predictions.reverse.shift.sensors
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
        @prediction_example_set.each do |prediction|
          if prediction.result.include?("survives")

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
                  if !check_for_G_hypotheses_existance(prediction, sensor)
                    hypothesis[sensor.name.to_sym] = ""
                  end
                end
              end
            end

          elsif prediction.result.include?("dies")

            # Specialize G to exclude the negative example
            @S.each do |hypothesis|
              hypothesis.each do |input|
                hypothesis_differences = EMPTY_SLOT.dup
                # input = [name, value]
                if input.last != prediction.sensors.find_by(name: input.first).value
                  if input.last != ""
                    hypothesis_differences[input.first] = input.last
                  end

                  new_entry = insert_set(input)

                  if @G.include?(new_entry)
                    # Eliminate from G non-minimal hypotheses
                    # Add composed elements if they contain same base values

                    position = @G.index(new_entry)
                    add_element = new_entry.merge(hypothesis_differences)
                    @G[position] = add_element
                  else
                    @G << new_entry unless @G.include?(new_entry)
                  end
                end
              end
            end

            # Only maximal elements are added to G to solve "Eliminate from G non-minimal hypotheses"
          end
        end

        # Eliminate from G empty case if it contains anything else
        @G.count.times do
          @G.slice!(@G.index(EMPTY_SLOT)) if @G.count > 1 and @G.include?(EMPTY_SLOT)
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

      def check_for_G_hypotheses_existance(prediction, sensor_match)
        @G.each do |hypothesis|
          prediction.sensors.each do |sensor|
            return false if
              sensor.name != sensor_match.name &&
              hypothesis[sensor.name.to_sym] != sensor.value
          end
        end
        true
      end

    end
  end
end
