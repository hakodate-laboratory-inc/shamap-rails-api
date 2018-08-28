class CreateV1Layers < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_layers, id: :uuid do |t|
      t.references :map, type: :uuid, foreign_key: { to_table: "v1_maps" }
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :v1_layers, [:map_id, :slug], unique: true
  end
end
