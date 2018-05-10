Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/github', as: :github_login
  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  get '/:nickname', to: 'users#show'
  get '/:nickname/repos', to: 'repos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
