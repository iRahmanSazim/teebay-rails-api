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
          delete 'truncate', to: 'users#truncate' 
        end
      end
      resources :products do
        collection do
          delete 'truncate', to: 'products#truncate'
        end
      end
      resources :conversations do 
        collection do
          get 'my_conversations', to: 'conversations#find_by_user'
          get '/:id/messages', to: 'conversations#find_messages_by_conversation'
        end
      end
      resources :messages
    end
  end
end