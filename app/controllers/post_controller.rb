class PostController < ApplicationController
  def index
    paramscheck
    @menu = params[:menu]
    @school = params[:school]

    @posts = Dbpost.where("menu = ? AND school = ? AND start_time BETWEEN ? AND ?",@menu,@school, DateTime.now.beginning_of_day, DateTime.now.end_of_day).reverse

  end

  def new
    if logincheck
      return
    end


    @dbpost = Dbpost.new
  end


  def join
    if logincheck
      return
    end


    post_data = Dbpost.find(params[:p_id])
    if post_data.fill_cnt <= post_data.now_cnt # 방에 모든사람이 채워졌을때
      render(html: "<script> alert('정원이 찼습니다.');location.href='/post/index?school=#{post_data.school}&menu=#{post_data.menu}'; </script>".html_safe, layout: 'application') and return
    end
    if current_user.info_id # 지금 세션의 유저가 다른방에 들어가있는지 확인
      render(html: "<script> alert('이미 참여 중입니다.');location.href='/post/index?school=#{post_data.school}&menu=#{post_data.menu}'; </script>".html_safe, layout: 'application') and return
    end

    # 게시글을 불러오고 참여인원수 증가 + 현재 참여인원 ID를 Info DB에 추가함.

    post_data.now_cnt = post_data.now_cnt+1
    current_user.info_id = post_data.info.id
    current_user.save
    post_data.save

    redirect_to "/post/index?school=#{post_data.school}&menu=#{post_data.menu}"
  end


  def create
    if logincheck
      return
    end


    # 
    t= Time.now.in_time_zone('Seoul')
    d = DateTime.new(t.year , t.month ,t.day, params[:hour].to_i ,params[:min].to_i ,0)


    dp = Dbpost.create(title: params[:dbpost][:title],
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
    Info.create(dbpost_id: dp.id)
    current_user.info_id = Info.last.id
    current_user.save

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
        return
      end
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