class NoticeController < ApplicationController
  def index
    @notices = Notice.all.reverse
  end

  def create
    @notices = Notice.new
  end

  def new
    @notice = Notice.new
    @notice.title = params[:notice][:title]
    @notice.content = params[:notice][:content]
    @notice.user_id = current_user.id
    @notice.save

    redirect_to '/notice/index'
  end

  def edit
  end

  def delete
  end
end
