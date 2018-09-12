Rails.application.routes.draw do
  get '/collections/:id/results', to: 'collections#results', as: 'collection_results'
  resources :collections do
    resources :items, except: [:index, :show]
  end
  get  '/health', to: 'health#check'
  get  '/:id', to: 'collections#show'
  root to: 'collections#index'
end
