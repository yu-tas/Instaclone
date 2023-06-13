class User < ApplicationRecord
  mount_uploader :user_image, ImageUploader
  validates :name, presence:true
  validates :email, presence:true
  validates :name,  presence: true, length: { maximum: 30 }  
  validates :email, presence: true, length: { maximum: 255 },                    
                                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :pictures
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
end
