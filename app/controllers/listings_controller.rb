class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def new
    @listing = Listing.new
    @listing.build_location
  end

  def create
    @listing = current_user.listings.build(listing_params)
    
    if @listing.save
      redirect_to @listing, notice: 'Annonce publiée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def index
    @premium_listings = Listing.where(premium: true, status: 'active')
                              .includes(:user, :category, :location, :images)
                              .order(created_at: :desc)
    
  end

  def show
    # @listing est déjà défini par before_action
  end

  def edit
    # formulaire d'édition
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Annonce mise à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to root_path, notice: "Annonce supprimée avec succès."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(
      :title, :price, :description, :category_id, :condition,
      location_attributes: [:city, :address],
      images: []
    )
  end
end
