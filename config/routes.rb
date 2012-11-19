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
    resources :applies, :only => [:index, :destroy] 
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
  
  match 'logout'           => 'main#logout',           :as => :logout,     :via => :get
  match 'force_logout'     => 'main#force_logout',     :as => :force_logout, :via => :get
  match 'apply'            => 'main#apply',            :as => :apply,      :via => :get
  match 'checkapply'       => 'main#checkapply',       :as => :checkapply, :via => :post
  match 'success'          => 'main#success',          :as => :success, :via => :get
  match 'checklogin'       => 'main#checklogin',       :as => :checklogin, :via => :post
  match 'checkforcelogout' => 'main#checkforcelogout', :as => :checkforcelogout, :via => :post
  
  root :to => 'main#index'
end
