require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'welcome#home'

  get :component_information, controller: 'predictions'
  get :simulation_hypotheses, controller: 'predictions'
  get :live_hypotheses, controller: 'predictions'
  get :sensor_readings, controller: 'sensors'

  resources :predictions, only: [:create, :update, :destroy], controller: 'predictions' do
    get :simulation, on: :collection
    get :live_prediction, on: :collection
  end

  mount Sidekiq::Web, at: '/plant_monitoring'
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [Rails.application.secrets.sidekiq_user, Rails.application.secrets.sidekiq_pass]
  end
end
