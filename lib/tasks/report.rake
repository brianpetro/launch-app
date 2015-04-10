desc "Daily report"
task :daily_report => :environment do
  users = User.where('created_at > ?', 1.day.ago)
  UserMailer.report(users).deliver_now
end
