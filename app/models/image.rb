class Image < ApplicationRecord
  belongs_to :listing
  validates :url, presence: true # S'assurer que l'URL est bien présente
end


