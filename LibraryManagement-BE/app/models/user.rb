class User < ApplicationRecord
    validates :first_name, :last_name, :email, presence: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, confirmation: { case_sensitive: true }
    has_many :orders
    has_secure_password

    before_save :ensure_authentication_token

    def ensure_authentication_token
        if authentication_token.blank?
          self.authentication_token = generate_authentication_token
        end
      end
    
    private
    
    def generate_authentication_token
        loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
        end
    end
end