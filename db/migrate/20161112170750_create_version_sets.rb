class CreateVersionSets < ActiveRecord::Migration[5.0]
  def change
    create_table :version_sets do |t|
      t.string :subject
      t.string :image
      t.boolean :prediction
      t.timestamps
    end
  end
end
