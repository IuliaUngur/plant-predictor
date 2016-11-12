class AddVersionSetsToSensors < ActiveRecord::Migration[5.0]
  def change
    add_reference :sensors, :version_set, index: true

    add_foreign_key :sensors, :version_sets, column: :version_set_id
  end
end
