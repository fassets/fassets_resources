Rails.application.routes.draw do
  devise_for :users

  mount FassetsCore::Engine => "/core"

  root :to => "FassetsCore::Catalogs#index"
end
