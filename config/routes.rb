Rails.application.routes.draw do
  root 'welcome#home'

  resources :predictions, only: [:create, :destroy], controller: 'predictions' do
    get :simulation, on: :collection
    get :live_prediction, on: :collection
  end
end
