Rails.application.routes.draw do
  devise_for :users

  mount FassetsResources::Engine => "/resources"

  root :to => "FassetsCore::Catalogs#index"
end
