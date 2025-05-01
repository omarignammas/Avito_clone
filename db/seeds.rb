# db/seeds.rb

puts "Nettoyage des données existantes..."
Location.destroy_all
Image.destroy_all
ListingAttribute.destroy_all
Listing.destroy_all
User.destroy_all
Category.destroy_all

# Créer des catégories
puts "Création des catégories..."
categories = [
  { name: 'Appartements', slug: 'appartements' },
  { name: 'Voitures', slug: 'voitures' },
  { name: 'Téléphone', slug: 'telephone' },
  { name: 'Maisons et villas', slug: 'maisons-et-villas' }
]
created_categories = {}
categories.each do |category_attrs|
  category = Category.create!(category_attrs)
  created_categories[category_attrs[:name]] = category
  puts "Catégorie #{category_attrs[:name]} créée avec succès."
end

# Créer des utilisateurs
puts "Création des utilisateurs..."
users = [
  { 
    username: 'Omar Tazi', 
    email: 'omar.tazi@example.com', 
    phone_number: '0600000001',
    password: 'password123',
    password_confirmation: 'password123'
  },
  { 
    username: 'Yayha zazi', 
    email: 'Yahya.zazi@example.com', 
    phone_number: '0600000002',
    password: 'password123',
    password_confirmation: 'password123'
  },
  { 
    username: 'Simo Life', 
    email: 'SimoLife@example.com', 
    phone_number: '0600000003',
    password: 'password123',
    password_confirmation: 'password123'
  }
]

created_users = {}
users.each do |user_attrs|
  user = User.find_by(email: user_attrs[:email])
  
  if user
    puts "L'utilisateur avec l'email #{user_attrs[:email]} existe déjà."
    created_users[user_attrs[:username]] = user
  else
    begin
      created_users[user_attrs[:username]] = User.create!(user_attrs)
      puts "Utilisateur #{user_attrs[:username]} créé avec succès."
    rescue ActiveRecord::RecordInvalid => e
      puts "Erreur lors de la création de l'utilisateur #{user_attrs[:username]}: #{e.message}"
    end
  end
end

puts "Création des utilisateurs terminée!"


# Créer des listings
puts "Création des listings..."
listings = [
  {
    title: 'Example Listing 1',
    description: 'A beautiful item for sale, perfect condition, only used once.',
    price: 100.0,
    condition: 'New',
    user: created_users['Omar Tazi'], # Associer explicitement à un utilisateur
    category: created_categories['Voitures']

  },
  {
    title: 'Example Listing 2',
    description: 'A luxurious car for sale, excellent condition, low mileage, ready to drive.',
    price: 200.0,
    condition: 'Excellent',
    user: created_users['Yayha zazi'], # Associer explicitement à un utilisateur
    category: created_categories['Appartements'] # ou 'Maisons et villas', selon ton besoin
  },
  # ... autres listings
]

listings.each do |listing_attrs|
  # Vérifier explicitement que user_id n'est pas nil avant de créer le listing
  if listing_attrs[:user].nil?
    puts "AVERTISSEMENT: Aucun utilisateur associé au listing '#{listing_attrs[:title]}'. Attribution au premier utilisateur."
    listing_attrs[:user] = User.first # Attribution par défaut si nécessaire
  end
  
  # Créer le listing
  Listing.create!(listing_attrs)
end

# Créer des localisations
puts "Création des localisations..."
cities = ['Casablanca', 'Rabat', 'Marrakech', 'Tanger']
cities.each_with_index do |city, index|
  Location.create!(city: city, listing: listings[index % listings.length])
end

# Listing téléphone
puts "Ajout d'un iPhone..."
phone = Listing.create!(
  user: created_users['Omar Tazi'],
  category: Category.find_by(slug: 'telephone'),
  title: 'Iphone 14 pro max 128go',
  description: 'A brand new Iphone 14 Pro Max...',
  price: 8000,
  condition: 'New',
  premium: true,
  status: 'active',
  created_at: 1.hour.ago
)
Location.create!(city: 'Casablanca', listing: phone)
Image.create!(listing: phone, url: '/images/iphone.jpg')

# Listing voiture
puts "Ajout d'une voiture..."
car = Listing.create!(
  user: created_users['Voitures particuliers certifiées'],
  category: Category.find_by(slug: 'voitures'),
  title: 'volkswagen golf 7',
  description: 'A very well-maintained Volkswagen Golf 7...',
  price: 165000,
  condition: 'Used',
  premium: true,
  status: 'active',
  created_at: 19.hours.ago,
  year: '2019',
  transmission: 'Manuelle',
  fuel_type: 'Diesel'
)
Location.create!(city: 'Casablanca', area: 'Aïn Chock', listing: car)
(1..8).each do |i|
  Image.create!(listing: car, url: "/images/volkswagen_#{i}.jpg")
end

puts "Ajout d'un appartement..."
apartment = Listing.create!(
  user: created_users['RESIDENCE PALMS'],
  category: Category.find_by(slug: 'appartements'),
  title: 'Appartement meublé centre ville belle vue',
  description: 'Appartement entièrement meublé avec une belle vue sur la ville, idéal pour les familles.',
  price: 450000,
  condition: 'Bon état', # Condition doit être une des valeurs définies : 'Neuf', 'Comme neuf', etc.
  premium: true,
  property_type: 'Appartements',
  rooms: 3,
  status: 'active',
  created_at: 23.hours.ago
)
Location.create!(city: 'Marrakech', listing: apartment, address: 'Toute la ville')
(1..14).each do |i|
  Image.create!(listing: apartment, url: "/images/apartment_#{i}.jpg")
end


puts "Initialisation des données terminée avec succès!"
