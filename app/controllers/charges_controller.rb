class ChargesController < ApplicationController
  def new
  end
  def create
    #Amount charged in cents
    @amount = 100
    
    customer = Stripe::Customer.create(
      :email => "tony@54footy.com",
      :card => params[:stripeToken]
    )
    
    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'Paid User',
      :currency => 'usd'
    )
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
  
  
end
