Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create', defaults: { role: :patient }

  resources :doctors, controller: :users, defaults: { role: :doctor } do
    resources :schedules, controller: :doctor_schedules
  end
  resources :patients, controller: :users, defaults: { role: :patient }
  resources :hospitals
  resources :appointments
end
