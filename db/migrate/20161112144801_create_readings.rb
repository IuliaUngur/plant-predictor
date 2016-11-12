class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.decimal :value
      t.references :sensor, null: false, index: true
      t.timestamps
    end

    add_foreign_key :readings, :sensors, column: :sensor_id
  end
end
