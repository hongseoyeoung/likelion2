class PostController < ApplicationController 
  before_action :logincheck, only: [:create, :delete_join, :delpage, :edit,:join,:new,:show]
  before_action :menu_list, only: [:new, :edit]
  def index
    paramscheck
    @menu = params[:menu]
    @school = params[:school]
    @posts = Dbpost.where("menu = ? AND school = ? AND start_time BETWEEN ? AND ?",@menu,@school, DateTime.now.beginning_of_day, (DateTime.now.end_of_day.change(day: DateTime.now.day+1))).reverse

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




  def update
    post = Dbpost.find(params[:p_id])
    @d = get_times
    post.start_time = @d
    post.title = params[:dbpost][:title]
    post.content = params[:dbpost][:content]
    post.menu = params[:dbpost][:menu]
    post.school = params[:dbpost][:school]
    post.fill_cnt = params[:dbpost][:fill_cnt]
    post.select_style = params[:dbpost][:select_style]
    post.select_eat = params[:dbpost][:select_eat]
    post.hope_gender = params[:dbpost][:hope_gender]
    post.save

    page_redirect and return
  end
  def create
    @d = get_times

    dp = Dbpost.new(postparams)
    dp.user_id = current_user.id
    dp.start_time = @d
    dp.save

    # 관계 형성
    Info.create(dbpost_id: dp.id)
    current_user.info_id = Info.last.id
    current_user.save

    page_redirect and return
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
    def get_times
      @flag = 0
      weight = 0
      if (params[:pm] == "true") && (params[:hour] != "12")
        weight = 12
      end
      @d = DateTime.now.change(hour: weight+ (params[:hour].to_i) ,min: params[:min].to_i)
      if @d < DateTime.now
        @flag = 1
        @d = DateTime.now.change(day: DateTime.now.day+1 ,hour: weight+ (params[:hour].to_i) ,min: params[:min].to_i)
      end
      return @d
    end

    def page_redirect
      if @flag == 1
        render(
          html: "<script>alert('내일 날짜로 등록됐습니다.');   location.href= '/post/index?school=#{params[:dbpost][:school]}&menu=#{params[:dbpost][:menu]}';  </script>".html_safe,
          layout: 'application'
        ) and return
      else
          render(
            html: "<script> location.href= '/post/index?school=#{params[:dbpost][:school]}&menu=#{params[:dbpost][:menu]}'; </script>".html_safe, layout: 'application'
          ) and return
      end
    end



    def menu_list
      @arr = ['치킨','피자','중식','족발','패스트푸드','분식']
      @hour_list =['0','1','2','3','4','5','6','7','8','9','10','11']
      @min_list = ['0','10','20','30','40','50']
    end

    def paramscheck
      if !(params[:school] && params[:menu])
        render(
          html: "<script>
          alert('잘못된 접근입니다.');
          location.href='/';      
          </script>".html_safe,
          layout: 'application'
        ) and return
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