class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dbposts
  has_many :notices
  has_many :comments
  belongs_to :info, :optional => true
  mount_uploader :image, ImageUploader
end
