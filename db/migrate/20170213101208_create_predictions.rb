class CreatePredictions < ActiveRecord::Migration[5.0]
  def change
    create_table :predictions do |t|
      t.boolean :result
      t.string :environment
      t.datetime :created_at, default: nil, null: false
    end
  end
end
