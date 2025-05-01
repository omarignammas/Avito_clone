class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :condition
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :status
      t.boolean :premium

      t.timestamps
    end
  end
end
