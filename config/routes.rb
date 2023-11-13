Rails.application.routes.draw do
  root "application#index"
  
  namespace :api do 
    namespace :v1 do
      resources :users, module: 'users' do
        devise_for :users, controllers: {
          registrations: 'api/v1/users/registrations',
          sessions: 'api/v1/users/sessions',
        }
        collection do
          delete 'truncate', to: 'users#delete_all' # todo - remove later
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