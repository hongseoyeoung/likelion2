class Notice < ApplicationRecord
  belongs_to :user
  paginates_per 20
  has_many :impressions, :as=>:impressionable
  #조회수
  def impression_count
  	impressions.size
  end

  def unique_impression_count
  	# impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
  	# so getting keys from the hash and calculating the number of keys
  	impressions.group(:ip_address).size.keys.length #TESTED
  end

end
