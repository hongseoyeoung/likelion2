class Dbpost < ApplicationRecord
  belongs_to :user
  has_one :info
  has_many :comments
end
