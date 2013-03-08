ActiveAdmin.register Payment do
  index do 
    column "User_id", :user_id
    column "User" do |payment|
      payment.user_name
    end
    column "Paid On", :created_at 
    column :stripe_customer_id
    column :amount
    
    default_actions
  end
end
