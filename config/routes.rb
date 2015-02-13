TrustyCms::Application.routes.draw do
  namespace :admin do
    resources :festivity_category_types
  end
end
