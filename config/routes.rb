Huiyuan::Application.routes.draw do
  resources :users

  namespace :ezadmin do
    resources :messages do
      member do
        post 'publish'
      end
    end
    resources :users
    resources :managers
    match 'login'      => 'dashboard#login',      :as => :login,       :via => :get
    match 'checklogin' => 'dashboard#checklogin', :as => :checklogin,  :via => :post
    match 'logout'     => 'dashboard#logout',     :as => :logout,      :via => :get
    match '/'          => 'dashboard#index',      :as => :dashboard,   :via => :get
  end
end
