Spree::Core::Engine.add_routes do
  scope '(:locale)', locale: /#{Spree.available_locales.join('|')}/, defaults: { locale: nil } do
    namespace :api, defaults: { format: 'json' } do
      namespace :v2 do 
        resources :homepage_banners, only: [:index]
        resources :products, only: [:index]
      end 
    end 
  end 
end