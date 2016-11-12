class CreateSensors < ActiveRecord::Migration[5.0]
  def change
    create_table :sensors do |t|
      t.string :name
      t.text :description
      t.string :type
      t.decimal :average_value
      t.timestamps
    end
  end
end
