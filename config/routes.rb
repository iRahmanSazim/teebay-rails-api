Rails.application.routes.draw do
  root "application#index"
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  namespace :api do 
    namespace :v1 do
      resources :users do
        collection do
          post 'login', to: 'users#login'
          delete 'truncate', to: 'users#truncate' # todo - remove later
        end
      end
      resources :products do
        collection do
          delete 'truncate', to: 'products#delete_all' # todo - remove later
        end
      end
    end
  end
end