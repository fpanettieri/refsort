Rails.application.routes.draw do
  resources :collections
  get  '/health', to: 'health#check'
  get  '/:id', to: 'collections#show'
  root to: 'collections#index'
end
