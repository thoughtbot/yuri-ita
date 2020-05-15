Rails.application.routes.draw do
  root to: "documentation#index"

  namespace :docs, module: nil do
    get "/:page", to: "documentation#show"
  end

  resources :movies, only: :index
end
