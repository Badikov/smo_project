SmoProject::Application.routes.draw do
  get "ats/create_links"

  get "ats/files"

  resources :customers do
    collection do
      match 'search' => 'customers#search', :via => [:get]
      # match 'search_person/:id' => 'customers#search_person', :as => 'search_person'
      get 'search_person' => 'customers#search_person'
      match 'edit_ops' => 'customers#edit_ops'
      match 'death_of_customer' => 'customers#death_of_customer'
    end
  end
  get "streets/index"

  get "streets/create"

  resources :filials
  resources :home

  resources :people do
    collection do
      # match 'search' => 'people#search', :via => [:get, :post], :as => :search
      # get 'result'
    end
  end
  
  resources :user_sessions
  
  match 'login' => 'user_sessions#new',      :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'vizits/new/:id' => 'vizits#new', :as => :new_vizit_person
  match 'print_polis/:id' => 'vizits#print_polis', :as => 'print_polis'
  match 'vizits/print_petition/:id' => 'vizits#print_petition', :as => 'print_petition'
  match 'home' => 'home#index', :as => :home
  
  resources :users  # give us our some normal resource routes for users
  resource :user, :as => 'account'  # a convenience route
  match 'signup' => 'users#new', :as => :signup
  
  # resources :filials
  # resources :home
  resources :docs
  resources :addres_gs
  resources :addres_ps
  resources :predstavitels
  resources :vizits 
  resources :tipdocs
  resources :oksms
  resources :streets
  resources :subektis
  resources :okatos
  
  resources :ops do
    collection do
      get 'files'
      get 'upload'
      get 'create_links'
    end
  end
  
  
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
   root :to => 'user_sessions#new'
#    'users#new'
#    
#    'people#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
#    match ':controller(/:action(/:id))(.:format)'
end
