class User < ApplicationRecord
    has_secure_password validations: false
  
    # ✅ Ajout de l'attachement avatar
    has_one_attached :avatar
  
    validates :phone_number, presence: true, uniqueness: true
  
    has_many :listings, dependent: :destroy
  
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.email = auth.info.email
        user.name = auth.info.name
        user.password = SecureRandom.hex(15)
        user.save
      end
    end
  end
  