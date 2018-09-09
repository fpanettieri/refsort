Rails.application.routes.draw do
  resources :collections
  get  '/:id', to: 'collections#show'
  root to: 'collections#index'
end
