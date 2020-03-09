Rails.application.routes.draw do
  get 'landings/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "landings#index"
end
