
class Listing < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category
  has_many :images, dependent: :destroy
  has_one :location, dependent: :destroy
  has_many :listing_attributes, dependent: :destroy
  
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :location, allow_destroy: true, reject_if: :all_blank
  
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :condition, presence: true
  validates :category_id, presence: true
  
  # Conditions pour les annonces
  CONDITION_OPTIONS = [
    ['Neuf', 'new'],
    ['Comme neuf', 'like_new'],
    ['Bon état', 'good'],
    ['État correct', 'fair'],
    ['À rénover', 'poor']
  ]
  
  # Statuts pour les annonces
  STATUS_OPTIONS = [
    ['Active', 'active'],
    ['En attente', 'pending'],
    ['Vendu', 'sold'],
    ['Archivé', 'archived']
  ]
  
  # Pour gérer les images lors de la création
  def image_urls=(urls)
    urls.each do |url|
      images.build(url: url) unless url.blank?
    end
  end
end
