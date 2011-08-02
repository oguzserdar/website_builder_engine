WebsiteBuilderEngine::Engine.routes.draw do
  
  resources :offerpages do
    member do
      get 'publish'
    end
  end

  resources :articles do
    member do
      get 'publish'
    end
  end

  resources :settings
  
  root :to => "home#index"
  
end
