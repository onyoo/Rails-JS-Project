To Do List:

  O-include Facebook auth (oauth)
  O-use nested routes:
      resources :posts, ~~~shallow: true~~~ do
        resources :comments do
          resources :versions
        end
      end
  -Your forms should correctly display validation errors. Your fields should be enclosed within a fields_with_errors class and error messages describing the validation failures must be present within the view.
  -build ratings and/or comments
  -work on validators ex: validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  -make sure errors are used and working