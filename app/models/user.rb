class User < ApplicationRecord  
  has_secure_password

  has_many :tweets, dependent: :destroy

  validates :name, presence: true
  validates :graveyard, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, uniqueness: true

end
