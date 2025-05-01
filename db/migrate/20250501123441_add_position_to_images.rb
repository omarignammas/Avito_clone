class AddPositionToImages < ActiveRecord::Migration[8.0]
  def change
    add_column :images, :position, :integer
  end
end
