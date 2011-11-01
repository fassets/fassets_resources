Rails.application.routes.draw do
  devise_for :users

  mount FassetsCore::Engine => "/fassets-core"

  root :to => "catalogs#index"
end
