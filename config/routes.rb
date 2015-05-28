Rails.application.routes.draw do

  root :to => "site/home#index"
  get 'contacts', to: "site/home#contacts"
  get 'careers', to: "site/home#careers"
  get 'careersv2', to: "site/home#careers"

  get 'works', to: "site/home#works"
  get 'about', to: "site/home#about"
  get 'blog', to: "site/home#blog"


  get 'cms' => 'cms#index'
  get 'cms/*path' => 'cms#index'
  

  namespace :api, defaults: { format: 'json' } do
    resource :session, only: %i(show create destroy)
    resources :posts
    resources :post_categories
  end

end
