Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :alerts

  get "up" => "rails/health#show", as: :rails_health_check

  root to: redirect("alerts")
end
