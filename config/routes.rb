Huiyuan::Application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'

  resources :users do
    member do
      post 'notice'
      get  'find'
    end
  end
  resources :user_messages, :only => [:show] do
    collection do
      post "readall"
    end
  end
  namespace :ezadmin do
    resources :messages do
      member do
        post 'publish', 'del_photo'
      end
    end
    resources :users do
      collection do
        get 'online'
      end
      member do
        post 'kickout'
      end
    end
    resources :managers
    match 'login'      => 'dashboard#login',      :as => :login,       :via => :get
    match 'checklogin' => 'dashboard#checklogin', :as => :checklogin,  :via => :post
    match 'logout'     => 'dashboard#logout',     :as => :logout,      :via => :get
    match '/'          => 'dashboard#index',      :as => :dashboard,   :via => :get
  end
  
  match 'login' => 'main#login',           :as => :login,      :via => :get
  match 'logout' => 'main#logout',         :as => :logout,     :via => :get
  match 'checklogin' => 'main#checklogin', :as => :checklogin, :via => :post
  
  root :to => 'main#index'
end
