ActiveAdmin.register User do
  index do
    column :email
    column :first_name
    column :last_name
    column :profile_name
    column "Stared Using", :created_at 
    column "Last Made a Change", :updated_at
    default_actions
  end
end
