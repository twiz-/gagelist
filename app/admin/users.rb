ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :profile_name
    column :paid_user
    column "Stared Using", :created_at 
    column "Last Made a Change", :updated_at
 
    default_actions
  end
  
  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :profile_name
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
