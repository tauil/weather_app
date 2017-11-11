Rails.application.routes.draw do
  root 'home#index'
  get :weather, controller: :home
end
