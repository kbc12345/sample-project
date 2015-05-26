Rails.application.routes.draw do

  root :to => "site/home#index"
  
  get 'cms' => 'cms#index'
  get 'cms/*path' => 'cms#index'
  
end
