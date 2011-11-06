Rails.application.routes.draw do
  resources :catalogs, :controller => 'FassetsCore::Catalogs' do
    resources :facets, :controller => 'FassetsCore::Facets' do
      resources :labels, :controller => 'FassetsCore::Labels' do
        collection do
          put :sort
        end
      end
    end
    put :add_asset
  end

  resources :classifications, :controller => 'FassetsCore::Classifications'

  resources :users do
    resources :tray_positions, :controller => 'FassetsCore::TrayPositions' do
      collection do
        put :replace
      end
    end
  end

  # assets
  resources :urls, :controller => 'FassetsCore::Urls'
  resources :file_assets, :controller => 'FassetsCore::FileAssets' do
    member do
      get :thumb
      get :preview
      get :original
    end
  end

  match 'asset/:id/preview' => 'FassetsCore::Assets#preview'
  match 'asset/:id/edit' => 'FassetsCore::Assets#edit'

  root :to => "Catalogs#index"
end
