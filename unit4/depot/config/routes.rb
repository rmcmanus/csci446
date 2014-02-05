Depot::Application.routes.draw do
  resources :line_items

  resources :adoptions

  get "agency/index"
  resources :animals

  root :to => 'agency#index', :as => 'agency'
  
end
