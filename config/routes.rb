Rails.application.routes.draw do
  root 'welcome#home'

  resources :readings, controller: 'readings'
  resources :sensors, controller: 'sensors'
  resources :version_sets, controller: 'version_sets'
end
