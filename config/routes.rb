Refuge::Application.routes.draw do

  devise_for :users

  root :to=> "dashboard#index"

  match '/members/search' => 'members#search', :via=>:post
  match '/members/mail' => 'members#mail_member', :via=>:post

  namespace :admin do
    post 'conf', :controller => 'conf'
    put 'occupation', :controller => 'occupation'

    resources :categories, :only => [:create, :update, :destroy]
    resources :locations,  :only => [:create, :update, :destroy]
    resources :surveys,    :only => [:create, :update, :show]
    resources :answers,    :only => [:create, :destroy]

  end

  resources :images, :only => [:index, :create, :destroy]
  resources :members
  resources :pages
  resources :dashboard
  resources :admin, :only => 'show'
end

