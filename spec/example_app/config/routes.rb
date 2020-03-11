Rails.application.routes.draw do
  root to: "landings#index"

  resources :movies, only: :index
end
