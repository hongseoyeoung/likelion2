namespace :post do
  desc "TODO"
  task post_user_del:, :environment do
    Dbpost.where("start_time < ?", DateTime.now).each do |p|
      p.info.users.each do |u|
        u.info_id = nil
      end
      # 이중포문이라 걱정이 되지만, info.users는 맥시멈 10이므로..
      # 해당글을 삭제하면..? 그럼 추후 전체량이 줄어서 데이터량이 많아져도 상관없음.
    end
  end

end
