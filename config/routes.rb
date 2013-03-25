Gagelist::Application.routes.draw do
  
  

  devise_for :users, :controllers => {:registrations => "registrations" } 
  
  devise_scope :user do
    match '/edit_password' => "registrations#edit_password", :as => 'edit_password'
    match '/update_password' => "registrations#update_password", :as => 'update_password'
    match '/confirmation_message' => "registrations#confirmation_message", :as => :confirmation_message
    match '/set_profile_name' => "registrations#set_profile_name", :as => :set_profile_name
  end
 
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  
  resources :activities
  
  resources :lists do
    collection do
      get 'completed'
    end  
    
    member do
      get 'mark_complete'
      get 'mark_uncomplete'
    end  
      
    resources :tasks do
      member do
        post 'complete'
      end  
    end
    
    match 'remove_membership'
  end
  
  resources :charges
  resources :invitations
  match 'invitation/accept/:token' => "invitations#accept", :as => :accept_invitation
  
  post '/tasks/sort', :controller => 'tasks', :action => 'sort', :as => 'sort_tasks'
  
  #resources :lists, :collection => { :sort => :post }, :as => 'sort_lists'

  root :to => 'front#index'
  match '/benefits' => 'front#benefits'
  match '/pricing' => 'front#pricing'
  match '/does' => 'front#does'
  match '/terms' => 'front#terms'
  
  match 'lists/:list_id/tasks/:id/complete' => 'tasks#complete', :as => :complete_task
  match 'lists/:list_id/tasks/:id/remove' => 'tasks#destroy', :as => :remove_task
  match 'lists/:list_id/tasks/:id/incomplete' => 'tasks#incomplete', :as => :incomplete_task
  
  #match 'list/:list_id/invite-user' => 'lists#invite_user', :as => :invite_user
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
