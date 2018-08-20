Rails.application.routes.draw do
  devise_for :users,:controllers => { :registrations => "user/registrations"}
  root "home#index"
  resources :products
  resources :locations
resources :users, except: :create


post 'create_user' => 'users#create', as: :create_user  
get 'signup', to: 'users#new'
get 'search_products_path', to: "products#search"
get 'disable_user/:id', to: "users#disabled", as: 'disable_user'
get 'retrieved_item/:id', to: "products#retrieved_item", as: 'retrieved_item'
get '/about', to: 'abouts#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
