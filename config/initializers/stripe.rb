#Rails.configuration.stripe = {
  #:publishable_key =>  #ENV['PUBLISHABLE_KEY'],
  #:secret_key      =>  #ENV['SECRET_KEY']
#}

#Stripe.api_key = Rails.configuration.stripe[:secret_key]

Stripe.api_key = ENV['SECRET_KEY']
STRIPE_PUBLIC_KEY = ENV['PUBLISHABLE_KEY']
REGISTRATION_AMOUNT = 50
