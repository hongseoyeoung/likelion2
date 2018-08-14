class Info < ApplicationRecord
  belongs_to :dbpost
  has_many :users
end
