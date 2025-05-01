class HomeController < ApplicationController
  def index
      @premium_listings = Listing.where(premium: true)
      @listings = Listing.all
    
    @categories = [
      { name: "VOITURES D'OCCASION", icon: "car", path: "/cars" },
      { name: "MOTOS", icon: "motorcycle", path: "/motorcycles" },
      { name: "VENTES IMMOBILIÈRES", icon: "home", path: "/real_estate" },
      { name: "LOCATION IMMOBILIÈRE", icon: "key", path: "/rentals" },
      { name: "APPARTEMENT LOCATION DE", icon: "building", path: "/apartments" },
      { name: "MAISON ET JARDIN", icon: "couch", path: '/garden' },
      { name: "INFORMATIQUE, MULTIMEDIA ET", icon: "laptop", path: "/electronics" },
      { name: "HABILLEMENT ET MODE", icon: "tshirt", path: "fashion" }
    ]
  end
end
