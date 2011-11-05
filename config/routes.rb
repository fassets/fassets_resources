FassetsCore::Engine.routes.draw do
  resources :catalogs do
    resources :facets do
      resources :labels do
        collection do
          put :sort
        end
      end

      put :add_asset
    end
  end

  resources :classifications

  resources :users do
    resources :tray_positions do
      collection do
        put :replace
      end
    end
  end

  # assets
  resources :urls
  resources :file_assets do
    member do
      get :thumb
      get :preview
      get :original
    end
  end

  match 'assets/:id/preview' => 'assets#preview'
  match 'assets/:id/edit' => 'assets#edit'

  root :to => "Catalogs#index"
end
