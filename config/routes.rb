Rails.application.routes.draw do
  resources :collections do
    resources :items, except: [:index, :show]
  end

  get  '/health', to: 'health#check'
  get  '/:id', to: 'collections#show'
  root to: 'collections#index'
end
