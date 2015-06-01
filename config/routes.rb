Rails.application.routes.draw do

  resources :high_scores
  root :to => "site/home#index"

  ###########
  # statics
  ###########
  get 'contacts', to: "site/home#contacts"
  get 'careers', to: "site/home#careers"
  get 'careersv2', to: "site/home#careers"

  get 'works', to: "site/home#works"
  get 'about', to: "site/home#about"
  get 'blogv2', to: "site/home#blogv2"

  resource :messages, only: %i(create)



  ###########
  # BLOG
  ###########
  resources :blog, only: %i(show index)
  

  ###########
  # CMS
  ###########
  get 'cms' => 'cms#index'
  get 'cms/*path' => 'cms#index'

  namespace :api, defaults: { format: 'json' } do
    resource :session, only: %i(show create destroy)
    resources :posts
    resources :post_categories
    resources :messages, only: %i(index destroy)
  end

end
