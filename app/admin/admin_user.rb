ActiveAdmin.register AdminUser do     
  index do                            
    column :email                     
    column :current_sign_in_at do |user|
      user.current_sign_in_at.in_time_zone("Pacific Time (US & Canada)")
    end        
    column :last_sign_in_at do |user|
      user.last_sign_in_at.in_time_zone("Pacific Time (US & Canada)")
    end           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end                                   
