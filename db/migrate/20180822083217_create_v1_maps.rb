class CreateV1Maps < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_maps, id: :uuid do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :v1_maps, :slug, unique: true
  end
end
