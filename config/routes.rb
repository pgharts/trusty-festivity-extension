TrustyCms::Application.routes.draw do
  namespace :admin do
    post 'assets/async_create' => 'assets#async_create', as: 'async_create_asset'

    resources :festivity_category_types
    resources :festivity_categories
    resources :festivity_performances
  end
  get 'search' => 'search#show'
  resources :events, controller: :festivity_events, only: [:index, :show]
  resources :markets, controller: :festivity_markets, only: [:index, :show]
  resources :locations, controller: :festivity_locations, only: [:show]
  resources :areas, controller: :festivity_location_areas, only: [:show]

end
