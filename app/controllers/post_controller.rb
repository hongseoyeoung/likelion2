class PostController < ApplicationController 
  before_action :logincheck, only: [:create, :delete_join, :delpage, :edit,:join,:new,:show]

  def index
    paramscheck
    @menu = params[:menu]
    @school = params[:school]
    @posts = Dbpost.where("menu = ? AND school = ? AND start_time BETWEEN ? AND ?",@menu,@school, DateTime.now.beginning_of_day, DateTime.now.end_of_day).reverse

  end
  def update
    
  end
  def new
    # 참여중이라면 return 
    if current_user.info_id
      render(html: "<script> alert('이미 참여 중입니다.');history.back();</script>".html_safe, layout: 'application') and return
    end

    @dbpost = Dbpost.new
  end


  def join

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



  def delpage
    data = Dbpost.find(params[:p_id])
    school = data.school
    menu = data.menu

    # 유저들의 info_id값을 변경
    
    data.info.users.each do |x|
      x.info_id = nil
      x.save
    end


    data.info.destroy
    data.destroy
    
    redirect_to "/post/index?school=#{school}&menu=#{menu}"
  end





  def create
    # 
    t= Time.now.in_time_zone('Seoul')
    d = DateTime.new(t.year , t.month ,t.day, params[:hour].to_i ,params[:min].to_i ,0)

    dp = Dbpost.new(postparams)
    dp.user_id = current_user.id
    dp.start_time =d
    dp.save

    # dp = Dbpost.create(title: params[:dbpost][:title],
    #               content: params[:dbpost][:content],
    #               menu: params[:dbpost][:menu],
    #               school: params[:dbpost][:school],
    #               user_id: current_user.id,
    #               start_time: d,
    #              fill_cnt: params[:dbpost][:fill_cnt],
    #              select_style: params[:dbpost][:select_style],
    #               select_eat:params[:dbpost][:select_eat],
    #              hope_gender:params[:dbpost][:hope_gender]
    #             )
    Info.create(dbpost_id: dp.id)
    current_user.info_id = Info.last.id
    current_user.save

    redirect_to "/post/index?school=#{params[:dbpost][:school]}&menu=#{params[:dbpost][:menu]}"
  end

  def edit
    @postdata = Dbpost.find(params[:id])
  end


  def show
    @postdata = Dbpost.find(params[:p_id])

  end
  
  def delete_join
    postdata = Dbpost.find(params[:p_id])

    # 참여자가 아닌 경우 보낸다
    if postdata.info.id != current_user.info_id
      redirect_to '/' and return 
    end
    

    # 접속된 유저의 info_id 삭제
    current_user.info_id = nil
    postdata.now_cnt = postdata.now_cnt-1
    
    postdata.save
    current_user.save

    redirect_to "/post/index?school=#{postdata.school}&menu=#{postdata.menu}"
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
        ) and return
      end
    end
    def postparams
      params.require(:dbpost).permit(:title, :content,:menu,:school,:fill_cnt,:select_style,:select_eat,:hope_gender)
    end
end