Rails.application.routes.draw do
  root 'welcome#home'

  get :component_information, controller: 'predictions'
  get :simulation_hypotheses, controller: 'predictions'
  get :live_hypotheses, controller: 'predictions'
  get :sensor_readings, controller: 'sensors'

  resources :predictions, only: [:create, :update, :destroy], controller: 'predictions' do
    get :load, on: :member
    get :simulation, on: :collection
    get :live_prediction, on: :collection
  end
end
