Rails.application.routes.draw do
  resources :problems, :except => [:edit, :destroy] do
    get :close, on: :member
	  resources :notes, :only => [:create], :shallow => true do
      get :choose, on: :member
    end
  end
  resources :users, :only => [:new, :create]
  resource :login, :only => [:new, :create, :destroy, :show]

  get '/login/show/:id', to: 'logins#show', as: :login_show
	get 'users/activate/:activation_key' => 'users#activate', as: :activate_user
	patch 'users/activate' => 'users#update'

  root 'problems#index'
end
