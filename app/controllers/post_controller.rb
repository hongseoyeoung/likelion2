class PostController < ApplicationController
  def index
    paramscheck
    @menu = params[:menu]
    @school = params[:school]

    @posts = Dbpost.where("menu = ? AND school = ?",@menu,@school).reverse

  end
  
  def new
    @dbpost = Dbpost.new
  end
  def create
    Dbpost.create(title: params[:dbpost][:title],
                  content: params[:dbpost][:content],
                  menu: params[:dbpost][:menu],
                  school: params[:dbpost][:school],
                  user_id: current_user.id
                  )
    redirect_to "/post/index?school=#{params[:dbpost][:school]}&menu=#{params[:dbpost][:menu]}"
  end







  private
    def paramscheck
      if !(params[:school] && params[:menu])
        render(
          html: "<script>
          alert('잘못된 접근입니다.');
          location.href='/';      
          </script>".html_safe,
          layout: 'application'
        )
      end
    end
end