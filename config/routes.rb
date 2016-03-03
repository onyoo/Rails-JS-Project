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

end
