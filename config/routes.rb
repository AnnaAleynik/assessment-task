Rails.application.routes.draw do
  root to: "home#show"

  resources :searchable_movies, only: %i[index]
end
