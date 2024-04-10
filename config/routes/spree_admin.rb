Spree::Core::Engine.add_routes do
  scope '(:locale)', locale: /#{Spree.available_locales.join('|')}/, defaults: { locale: nil } do
    namespace :admin do
      resources :homepage_banners do
        collection do
          post :update_positions
        end
      end
    end 
  end 
end
