class ModifyTables < ActiveRecord::Migration[5.0]
  def change
    remove_column :sensors, :updated_at, :datetime
    remove_column :sensors, :version_set_id, :integer

    drop_table :version_sets
    drop_table :readings
  end
end
