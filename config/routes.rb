Refuge::Application.routes.draw do

  devise_for :users

  root :to=> "ads#index"

  match 'members/search' => 'members#search', :via => :post
  match 'members/mail' => 'members#mail_member', :via => :post
  match 'blog/category/:id' => 'blog#show_category',          :as => :blog_category, :via => :get
  match 'blog/archives/:year/:month' => 'blog#show_archives', :as => :blog_archives, :via => :get

  resources :blog
  resources :images,   :only => [:index, :create, :destroy]
  resources :surveys,  :only => [:create]
  resources :comments, :only => [:destroy]
  resources :ads,      :only => [:index, :create, :destroy]
  resources :members do
    post 'view_as_user'
  end
  resources :pages
  resources :dashboard
  resources :events,   :only => [:index, :create]

  match 'medias/download/:id' => 'medias#download', :as => :media_download, :via => :get
  resources :medias, :only => [:index, :show, :create]

  namespace :admin do

    match 'occupation' => 'locations#occupation', :via=>:put

    resources :galleries,       :only => [:index, :create, :destroy]
    resources :events,          :only => [:update]
    resources :conf,            :only => [:index, :create]
    resources :headlines,       :only => [:index, :create]
    resources :stats,           :only => [:index]
    resources :menus,           :only => [:index, :create]
    resources :locations,       :only => [:index, :create, :update, :destroy]
    resources :blog_categories, :only => [:index, :create, :update, :destroy]
    resources :ads,             :only => [:index, :create, :update, :destroy]
    resources :newsletters

    match 'medias/media/:id' => 'medias#delete_media', :as => :delete_media, :via => :delete
    resources :medias,     :only => [:index, :create, :update, :destroy] do
      member do
        post :upload_media
      end
    end

    resources :surveys,    :only => [:index, :create, :update, :destroy, :show] do
      member do
        post   :create_answer
        delete :delete_answer
      end
    end
  end

  namespace :api do
    match 'blog/feed' => 'blog#feed', :as => 'rss_feed'
  end

  namespace :iframes do
    match 'members/search' => 'members#search', :via => :post, :as => 'members_search'
    resources :members, :only => [:index, :show]
  end

  match 'thumbnails/:model/:id/:method/:style/:name' => Dragonfly[:images].endpoint { |params, app|
    params[:model].camelize.constantize.find(params[:id].to_i).send(params[:method]).thumb(params[:style])
  }
end

