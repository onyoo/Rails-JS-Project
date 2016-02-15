Rails.application.routes.draw do

  get '/subjects' => 'subjects#index', as: 'home_subjects'
  get '/resources' => 'resources#index', as: 'resources'

  # post '/subjects/:category_id/subjects' => 'subjects#create', as: 'category/subjects'
  patch '/categories/:category_id/subjects/:id/edit' => 'subjects#update', as: 'edit_subject'
  patch '/categories/:category_id/subjects/:subject_id/resources/:id/edit' => 'resources#update', as: 'edit_resource'

  resources :users, only: [:index, :new, :create, :edit, :show, :update]
  get 'users/p/:id' => 'users#new_password', as: "new_password"
  post 'users/p/:id' => 'users#post_password', as: "post_password"

  resources :categories do
    resources :subjects, only: [:create, :new, :edit, :show, :destroy] do
      resources :resources, only: [:create, :edit, :new, :show, :update, :destroy]
    end
  end

  get 'home' => 'application#home'

  get 'categories/:id/new' => 'subjects#new', as: "new_subject"
  get 'categories/:category_id/:subject_id/new' => 'resources#new', as: "new_resource"

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'tree_builder/new' => 'categories#plant_tree', as: "tree"
  post 'tree_builder/new' => 'categories#grow_tree', as: "grow"

  get '/auth/facebook', as: 'facebook_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('home')
  # get 'signout', to: 'sessions#destroy', as: 'logout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
