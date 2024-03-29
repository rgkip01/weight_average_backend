Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :projetos, only: [:create, :index]
    resources :criterios, only: [:create, :update]
  end
end
