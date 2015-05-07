Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users, only: [:show] do
    resources :todo_lists, only: [:create, :show]
  end

  root to: 'welcome#index'
end
