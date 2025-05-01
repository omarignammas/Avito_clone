class CreateListingAttributes < ActiveRecord::Migration[8.0]
  def change
    create_table :listing_attributes do |t|
      t.string :name
      t.string :value
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
