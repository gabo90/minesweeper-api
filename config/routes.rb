Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :boards, only: %i[show] do
        resources :cells, only: %i[index]
      end
      resources :cells, only: %i[update]
      resources :players, except: %i[delete] do
        resources :games, only: %i[index create]
      end
      resources :games
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
