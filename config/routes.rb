Rails.application.routes.draw do
  namespace :api do
    defaults format: :json do
      resources :todo_lists, path: :todolists do
        resources :tasks do
          member do
            patch :complete
          end
        end
      end
    end
  end

  resources :todo_lists, only: %i[index new], path: :todolists
end
