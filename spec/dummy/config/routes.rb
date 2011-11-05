Rails.application.routes.draw do
  devise_for :users

  root :to => "FassetsCore::Catalogs#index"
end
