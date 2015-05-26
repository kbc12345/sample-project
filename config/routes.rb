Rails.application.routes.draw do

  root :to => "site/home#index"
  get 'contacts', to: "site/home#contacts"

  get 'cms' => 'cms#index'
  get 'cms/*path' => 'cms#index'
  
end
