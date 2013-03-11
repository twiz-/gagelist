namespace :refreshrunner do
  desc "mark_user_as_paid"    
  # => sample rake refreshrunner:mark_user_as_paid[5]
  task :mark_user_as_paid, [:user_id] => :environment do |t, args|  
    user = User.find(args[:user_id]) rescue nil
    unless user.blank?
      user.paid_user = true
      user.save
    end
    puts 'Success!'
  end
end
