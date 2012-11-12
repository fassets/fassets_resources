FassetsResources::Engine.routes.draw do
  # assets
  resources :urls
  resources :file_assets do
    member do
      get :thumb
      get :preview
      get :original
    end
  end

  post '/wikipedia_search', :as => 'wikipedia_search', :action => 'wikipedia_images', :controller => "file_assets"
end
