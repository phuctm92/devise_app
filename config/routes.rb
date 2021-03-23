Rails.application.routes.draw do
  get 'errors/show'
  root 'home#index'

  devise_for :users

  get 'about', to: 'home#about', as: :about
  get ':username', to: 'users#show', as: :user_profile
  match '*path', to: 'errors#show', via: %i[get post]
end
