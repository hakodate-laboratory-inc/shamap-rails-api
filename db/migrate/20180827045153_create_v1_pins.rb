class CreateV1Pins < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_pins, id: :uuid do |t|
      t.references :map, type: :uuid, foreign_key: { to_table: "v1_maps" }
      t.references :layer, type: :uuid, foreign_key: { to_table: "v1_layers" }
      t.references :user, type: :uuid, foreign_key: true
      t.st_point :location, null: false
      t.jsonb :context, null: false, default: {}

      t.timestamps
    end
  end
end
