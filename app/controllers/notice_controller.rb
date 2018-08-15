class NoticeController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  
  def index
    @temp = params[:choice]
    @notices = Notice.where("choice = ?", @temp).all.reverse


  end

  def create
    if logincheck
      return
    end
    @notices = Notice.new

  end

  def new
    @notice = Notice.new
    @notice.title = params[:notice][:title]
    @notice.content = params[:notice][:content]
    @notice.user_id = current_user.id
    @notice.choice = params[:choice]
    @notice.save

    redirect_to "/notice/index?choice=#{params[:choice]}"
  end

  def show
    @notice = Notice.find params[:id]
  end

  def edit
    if current_user.id == owner.id
    @notice = Notice.find params[:id]
    end
  end

  def update
    notice = Notice.find params[:notice_id]
    notice.title = params[:notice_title]
  end

  def delete
  end

  def logincheck
      if !user_signed_in?
        render(
          html: "<script>
          alert('로그인이 필요합니다.');
          location.href='/users/sign_in';      
          </script>".html_safe,
          layout: 'application'
        ) and return true
      end
    end
end