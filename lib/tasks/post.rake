namespace :post do
  desc "Delete records older than 30 days"
  task post_user_del: :environment do
    p 'task 실행 중'
    Dbpost.where(['start_time < ?', DateTime.now]).each do |p|
      p.info.users.each do |u|
        u.info_id = nil
        u.save
      end
    end
  end
end