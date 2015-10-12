Rails.application.routes.draw do

  resources :high_scores
  root :to => "site/home#index"

  ###########
  # statics
  ###########
  get 'contact', to: "site/contact#index"
  get 'careers', to: "site/careers#index"
  get 'works', to: "site/works#index"
  get 'about', to: "site/about#index"

  resource :messages, only: %i(create)
  resource :applicants, only: %i(create)

  ###########
  # BLOG
  ###########
  resources :blog, only: %i(show index) do
    collection do
      get :search
    end
  end


  ###########
  # CMS
  ###########
  get 'cms' => 'cms#index'
  # get 'cms/*path' => 'cms#index'
  get 'billing' => 'cms#index'

  namespace :api, defaults: { format: 'json' } do
    resource :session, only: %i(show create destroy)
    resources :posts
    resources :post_categories
    resources :messages
    resources :applicants, only: %i(index destroy)
    resources :billings, only: %i(index create)
    resources :terms, only: %i(index update)
    resources :users
  end



end
