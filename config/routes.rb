Leedshack::Application.routes.draw do

  resources :hackers, :except => [:new, :destroy] do
    collection do
      get :food
      get :source
      post :download
    end
  end
  resources :hacker_sessions, :only => [:create, :destroy]
  resources :teams, :except => [:destroy] do
    member do
      post :join
    end
  end
  resources :categories, :only => [:new, :create]
  resources :microposts, :only => [:create]
  resources :hacks, :as => "submissions", :controller => "submissions", :path_names => { :new => 'submit', :edit => 'change' }, :except => [:destroy] do
    collection do
      get :full_list
    end
  end
  resources :foods, :only => [:new, :create, :show] do
    collection do
      get :orders
    end
  end
  resources :commits do 
    collection do 
     get :committed
     end
  end
  
  root :to => "pages#home"
  match "edit-profile",   :to => "hackers#edit",    :as => "edit_profile" 
  match "food",           :to => "hackers#food",    :as => "edit_food"
  match "source",         :to => "hackers#source",  :as => "source" 
  match "signin",         :to => "hackerSessions#new"
  match "signout",        :to => "hackerSessions#destroy"
  match "signup",         :to => "hackers#new"
  
end
