class AddPropertyTypeToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :property_type, :string
  end
end
