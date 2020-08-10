class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, null: true, foreign_key: true
      t.references :post, null: true, foreign_key: true

      t.timestamps
    end
  end
end
