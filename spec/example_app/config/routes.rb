Rails.application.routes.draw do
  resources :movies, only: :index

  root to: "movies#index"
end
