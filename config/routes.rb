Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  get '/shelters/:id/delete', to: 'shelters#destroy'
  post 'shelters', to: 'shelters#create'
  patch 'shelters/:id', to: 'shelters#update'
  # delete 'shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
end
