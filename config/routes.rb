Rails.application.routes.draw do
  root 'welcome#home'

  get :component_information, controller: 'predictions'

  resources :predictions, only: [:create, :destroy], controller: 'predictions' do
    get :simulation, on: :collection
    get :live_prediction, on: :collection
  end
end
