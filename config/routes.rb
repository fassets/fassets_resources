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

  match 'file_assets/:id' => 'FileAssets#update'
  match 'urls/:id' => 'Urls#update'
  match 'new_remote_file' => 'FileAssets#new_remote_file'
  match 'get_wiki_imgs' => 'FileAssets#get_wiki_imgs'
  match 'search_wiki_imgs' => 'FileAssets#search_wiki_imgs'
  match 'add_wiki_img' => 'FileAssets#add_wiki_image'
end
