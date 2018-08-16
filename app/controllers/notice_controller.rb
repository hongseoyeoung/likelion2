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
    @notice = Notice.find params[:id]
    @notice.choice = params[:choice]
  end

  def update
    @notice = Notice.find params[:id]
    @notice.title = params[:title]
    @notice.content = params[:content]
    @notice.save

    redirect_to "/notice/index?choice=#{@notice.choice}"
  end


  def delete
    @notice = Notice.find params[:id]
    temp = @notice.choice
    @notice.destroy

    redirect_to "/notice/index?choice=#{temp}"
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