Rails.application.routes.draw do
  resources :doctors, controller: :users, defaults: { role: :doctor } do
    resources :schedules, controller: :doctor_schedules
  end
  resources :patients, controller: :users, defaults: { role: :patient }
  resources :hospitals
  resources :appointments
end
