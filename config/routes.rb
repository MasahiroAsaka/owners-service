Rails.application.routes.draw do
  root "plans#index"
  devise_for :owners
  resources :plans, only:[:index, :show, :new, :create] do
    get 'pay', on: :collection
  end
  get '/orders/select_cources/:id', to: 'orders#select_cources'
  get '/orders/purchase/cvs/:id', to: 'orders#purchase_cvs'
  get '/orders/purchase/credit_card/:id', to: 'orders#purchase_credit_card'
  get '/orders/purchase/confirming/:id', to: 'orders#confirming'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
