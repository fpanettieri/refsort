Rails.application.routes.draw do
  resources :collections
  get  '/:slug', to: 'collections#sort'
  root to: 'collections#index'
end
