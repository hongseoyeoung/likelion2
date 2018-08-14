class Dbpost < ApplicationRecord
  belongs_to :user
  has_one :info
end
