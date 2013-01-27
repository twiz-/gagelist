ActiveAdmin.register List do
  index do 
    column :name
    column :user_id
    column "Stared Using", :created_at 
    column "Last Made a Change", :updated_at
    default_actions
  end
end
