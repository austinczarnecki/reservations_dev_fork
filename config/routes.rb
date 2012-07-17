Reservations::Application.routes.draw do



  match '/black_outs/flash_message' => 'black_outs#flash_message', :as => :flash_message

  resources :black_outs do
    member do
      get :flash_message
    end
  end

  root :to => 'catalog#index'

  resources :sessions
  resources :identities

  resources :requirements
  resources :documents, :equipment_objects
  
  resources :equipment_models do
    resources :equipment_objects
  end
  
  resources :categories do
    resources :equipment_models
  end
    
  resources :users do
    collection do
      get :check_out
      get :check_in
      get :find
    end
    resources :reservations
  end

  match '/reservations/renew/:id' => 'reservations#renew', :as => :renew
  match '/catalog/search' => 'catalog#search', :as => :catalog_search

  resources :reservations do
    member do
      get :check_out
      get :check_in
      get :show_all
      get :checkout_email
      get :checkin_email
      get :upcoming
    end
    get :autocomplete_user_last_name, :on => :collection
  end

  match '/reservations/manage/:user_id' => 'reservations#manage', :as => :manage_reservations_for_user
  match '/reservations/receipt/:user_id' => 'reservations#receipt', :as => :reservations_receipt_for_user
  match '/reservations/current/:user_id' => 'reservations#current', :as => :current_reservations_for_user
  # reservations views
  
  # reservation checkout / check-in actions
  match '/reservations/checkout/:user_id' => 'reservations#checkout', :as => :checkout
  match '/reservations/check-in/:user_id' => 'reservations#checkin', :as => :checkin
  
  match '/catalog/update_view' => 'catalog#update_user_per_cat_page', :as => :update_user_per_cat_page
  
  match '/catalog' => 'catalog#index', :as => :catalog
  match '/catalog/add_to_cart/:id' => 'catalog#add_to_cart', :as => :add_to_cart
  match '/catalog/remove_from_cart/:id' => 'catalog#remove_from_cart', :as => :remove_from_cart
  
  match '/cart/empty' => 'application#empty_cart', :as => :empty_cart
  match '/cart/update' => 'application#update_cart', :as => :update_cart
  
  match '/reports/index' => 'reports#index', :as => :reports
  match '/reports/:id/for_model' => 'reports#for_model', :as => :for_model_report
  match '/reports/for_model_set' => 'reports#for_model_set', :as => :for_model_set_reports
  match '/reports/update' => 'reports#update_report', :as => :update_report
  
  match '/:controller/:id/deactivate' => ':controller#deactivate', :as => 'deactivate'
  match '/:controller/:id/activate' => ':controller#activate', :as => 'activate'

  match '/logout' => 'application#logout', :as => :logout

  #match '/users/find' => 'users#find', :as => :find_user
  match '/app_configs/edit' => 'app_configs#edit', :as => :edit_app_configs
  match '/app_configs/update' => 'app_configs#update', :as => :update_app_configs   
  resources :app_configs, :only => [:edit, :update]
  
  match '/new_admin_user' => 'application_setup#new_admin_user', :as => :new_admin_user
  match '/create_admin_user' => 'application_setup#create_admin_user', :as => :create_admin_user
  resources :application_setup, :only => [:new_admin_user, :create_admin_user]
  
  match '/login_settings' => 'application_setup#login_settings', :as => :login_settings
  match '/new_app_configs' => 'application_setup#new_app_configs', :as => :new_app_configs
  match '/create_app_configs' => 'application_setup#create_app_configs', :as => :create_app_configs
  

  
  match ':controller(/:action(/:id(.:format)))' 

  match '/auth/cas/callback' => 'sessions#create'
  match '/auth/identity/callback' => 'sessions#create'
  match '/sessions/auth/identity/callback' => 'sessions#create'

  resources :identities

end
