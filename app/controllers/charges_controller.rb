class ChargesController < ApplicationController
  skip_before_filter :trail_ended?
  before_filter :profile_name_set?, :only => [:new]
  
  def new
  end
  
  def create
    #Amount charged in cents
    @error = false
    @amount = REGISTRATION_AMOUNT * 100
    @set_flag = false
    
    stripe_customer_id = current_user.stripe_customer_id #If already made a pyament before
    
    if stripe_customer_id.blank?
      customer = Stripe::Customer.create(
        :email => current_user.email,
        :card => params[:stripeToken]
      )
 
      stripe_customer_id = customer.id
      @set_flag = true
    end
    
    charge = Stripe::Charge.create(
      :customer => stripe_customer_id,
      :amount => @amount,
      :description => 'Paid User',
      :currency => 'usd'
    )
  
    #Create pyament object. Don't use create/update attributes
    payment = Payment.new
    payment.user_id = current_user.id
    payment.stripe_token = params[:stripeToken]
    payment.amount =  REGISTRATION_AMOUNT
    payment.email  = current_user.email
    payment.stripe_customer_id = stripe_customer_id
    payment.save
   
    if @set_flag
      current_user.paid_user = true
      current_user.save
    end    
    
  rescue Stripe::CardError => e
    @error = true
    flash[:error] = e.message
    redirect_to charges_path
  end
 
  private
  
  def profile_name_set?
    if current_user.invited_user?
      redirect_to edit_user_registration_path, :alert => "Please set your profile name first."
    end  
  end
  
end
