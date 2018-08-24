class MypageController < ApplicationController
  def index
  end

  def edit
  end

  def modify
  	redirect_to '/mypage/index'
  end
  def profile

  end
  def editprofile
  	user = User.find(current_user.id) 
  	user.image = params[:image]
  	user.save

  	redirect_to :back
  end
end
