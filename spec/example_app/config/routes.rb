Rails.application.routes.draw do
  root to: "documentation#index"

  resources :movies, only: :index
end
