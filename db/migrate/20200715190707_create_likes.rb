class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :user, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
    add_index :likes, [:likeable_id, :likeable_type]
  end
end
