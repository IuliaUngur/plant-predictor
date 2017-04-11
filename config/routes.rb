require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'welcome#home'

  get :component_information, controller: 'predictions'
  get :simulation_hypotheses, controller: 'predictions'
  get :live_hypotheses, controller: 'predictions'
  get :sensor_readings, controller: 'sensors'

  resources :predictions, only: [:create, :update, :destroy], controller: 'predictions' do
    get :load_data, on: :member
    get :simulation, on: :collection
    get :live_prediction, on: :collection
    get :reload_predictions, on: :collection
  end

  mount Sidekiq::Web, at: '/plant_monitoring'
end
