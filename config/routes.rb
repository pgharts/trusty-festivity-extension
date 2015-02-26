TrustyCms::Application.routes.draw do
  namespace :admin do
    post 'assets/async_create' => 'assets#async_create', as: 'async_create_asset'

    resources :festivity_category_types
    resources :festivity_categories
  end
end
