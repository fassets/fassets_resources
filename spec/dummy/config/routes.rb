Rails.application.routes.draw do
  devise_for :users

  mount FassetsResources::Engine => "/resources"

  root :to => "Catalogs#index"
end
