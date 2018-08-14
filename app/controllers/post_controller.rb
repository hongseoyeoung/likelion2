class PostController < ApplicationController
  def index
    paramscheck
    @menu = params[:menu]
    @school = params[:school]

    @posts = Dbpost.where("menu = ? AND school = ? AND start_time BETWEEN ? AND ?",@menu,@school, DateTime.now.beginning_of_day, DateTime.now.end_of_day).reverse

  end

  def new
    logincheck
    @dbpost = Dbpost.new
  end
  def join
    logincheck
      
  end

  def create
    logincheck


    # 
    t= Time.now.in_time_zone('Seoul')
    d = DateTime.new(t.year , t.month ,t.day, params[:hour].to_i ,params[:min].to_i ,0)


    Dbpost.create(title: params[:dbpost][:title],
                  content: params[:dbpost][:content],
                  menu: params[:dbpost][:menu],
                  school: params[:dbpost][:school],
                  user_id: current_user.id,
                  start_time: d,
              fill_cnt: params[:dbpost][:fill_cnt],
              select_style: params[:dbpost][:select_style],
              select_eat:params[:dbpost][:select_eat],
              hope_gender:params[:dbpost][:hope_gender],

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

    def logincheck
      if !user_signed_in?
        render(
          html: "<script>
          alert('로그인을 부탁드립니다.');
          location.href='/users/sign_in';      
          </script>".html_safe,
          layout: 'application'
        )
      end
    end
end