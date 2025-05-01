# app/models/location.rb
class Location < ApplicationRecord
  belongs_to :listing  # Ceci indique que chaque Location appartient à un Listing
end


