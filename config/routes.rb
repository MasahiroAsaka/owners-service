Rails.application.routes.draw do
  root "plans#index"
  devise_for :owners
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
