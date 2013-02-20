ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "gmail.com",
    :authentication => :plain,
    :user_name => "nosensitiveinfo@gmail.com",
    :password => "no1sensitiveinfo"
}
 
ActionMailer::Base.default_url_options[:host] = "staging23-refreshrunner.herokuapp.com"  
