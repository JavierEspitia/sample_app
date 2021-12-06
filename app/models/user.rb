class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 45 } # el name es necesario no puede ser null o blank
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i    
    validates :email, presence: true, length: { maximum: 200 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
