Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  get '/shelters/:id/pets', to: 'shelters#pets'
  post '/shelters', to: 'shelters#create'
  patch '/shelters/:id', to: 'shelters#update'
  delete 'shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/users/new', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users/:id', to: 'users#create'

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  get '/shelters/:id/reviews/:review_id/edit', to: 'reviews#edit'
  post '/shelters/:id', to: 'reviews#create'
  patch '/shelters/:id/reviews/:review_id', to: 'reviews#update'
  delete '/shelters/:id/reviews/:review_id', to: 'reviews#destroy'

  get '/applications/new', to: 'user_applications#new'
  get '/applications/:id', to: 'user_applications#show'
  post '/applications/:id', to: 'user_applications#create'
  patch '/applications/:id/:pet_id', to: 'user_applications#update'
end
