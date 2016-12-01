Rails.application.routes.draw do
  resources :professors, except: [:index] do
    collection do
      get 'login'
    end
  end
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :students
  resources :projects

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
