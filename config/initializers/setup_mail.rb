ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "gmail.com",
    :authentication => :plain,
    :user_name => ENV["GMAIL_USERNAME"],
    :password => ENV["GMAIL_PASSWORD"]
}
 
ActionMailer::Base.default_url_options[:host] = "staging23-refreshrunner.herokuapp.com/"  
