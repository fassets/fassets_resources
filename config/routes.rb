Rails.application.routes.draw do
  resources :catalogs do
    resources :facets do
      resources :labels do
        collection do
          put :sort
        end
      end
    end
    put :add_asset
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

  match 'asset/:id/preview' => 'Assets#preview'
  match 'asset/:id/edit' => 'Assets#edit'
  match 'catalog_box' => 'Catalogs#catalog_box'
  match 'box_content' => 'Catalogs#box_content'
  match 'box_facet' => 'Catalogs#box_facet'

  root :to => "Catalogs#index"
end
