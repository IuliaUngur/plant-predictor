class AddPredictionAndValuesToSensors < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :value, :string
    add_reference :sensors, :prediction, index: true

    add_foreign_key :sensors, :predictions, column: :prediction_id
  end
end
