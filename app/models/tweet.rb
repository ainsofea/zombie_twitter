# app/models/tweet.rb
class Tweet < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
end

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  has_many :tweets
  validates :email, presence: true, uniqueness: true
end
