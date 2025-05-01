class AddListingToLocations < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:locations, :listing_id)
      add_reference :locations, :listing, null: true, foreign_key: true
    end
  end
end


