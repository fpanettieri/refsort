Rails.application.routes.draw do
  get '/collections/:id/results', to: 'collections#results', as: 'collection_results'
  post '/collections/:id/vote', to: 'collections#vote', as: 'collection_vote'
  resources :collections do
    resources :items, except: [:index, :show]
  end
  get  '/health', to: 'health#check'
  get  '/:id', to: 'collections#show'
  root to: 'collections#index'
end
