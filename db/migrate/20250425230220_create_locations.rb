class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :city
      t.references :listing, foreign_key: true
      t.string :address # Ajouter l'attribut address ici
      t.timestamps
    end
  end
end



