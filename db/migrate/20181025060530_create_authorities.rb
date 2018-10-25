class CreateAuthorities < ActiveRecord::Migration[5.2]
  def change
    create_table :authorities do |t|
      t.references :v1_map, type: :uuid, foreign_key: true, null: false
      t.references :user, type: :uuid, foreign_key: true, null: false
      t.integer :authority, null: false

      t.timestamps
    end
    add_index :authorities, [:v1_map_id, :user_id], unique: true
  end
end
