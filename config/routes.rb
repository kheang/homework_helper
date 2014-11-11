Rails.application.routes.draw do
	get '/login/show/:id', to: 'logins#show', as: 'login_show'
	get 'problems/index'

  resources :problems, :except => [:edit] do
    get :close, on: :member
	  resources :notes, :only => [:index, :create], :shallow => true do
      get :choose, on: :member
    end
  end

  resources :users, :only => [:new, :create]
  resource :login, :only => [:new, :create, :destroy, :show]

	get 'users/activate/:activation_key' => 'users#activate', as: :activate_user
	patch 'users/activate' => 'users#update'
  root 'problems#index'
end
