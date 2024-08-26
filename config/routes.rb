Rails.application.routes.draw do

  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root :to =>"homes#top"
    get '/about' => 'homes#about'
    get "/mypage" => "users#show"
    resources :users, except: [:new, :index, :show, :create] do
      collection do
        patch :withdraw
        get :check
      end
    end
    resources :groups do
      resource :permits, only: [:create, :destroy]
      resource :group_user, only: [:create, :destroy]
      resources :group_characters
      resources :messages, only: [:create, :destroy]
      collection do
        get 'play_character/:id', action: :play_character, as: 'play_character_with_id'
      end
    end
    get "groups/:id/permits" => "groups#permits", as: :permits
    mount ActionCable.server => '/cable'
    resources :characters
    resources :schedules, except: [:index]
    get "/search", to: "searches#search"
  end

  devise_scope :user do
    get '/users/sign_out', to: 'public/sessions#destroy'
  end


  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    # resources :groups, only: [:show, :index, :destroy]
    resources :groups, only: [:index, :show, :destroy] do
      resource :group_user, only: [:destroy]
      # resource :group_character, except: [:new, :show, :edit]
      resources :messages, only: [:destroy]
    end
    resources :characters, only: [:index, :show, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    get "/search", to: "searches#search"
  end

  devise_scope :admin do
    get '/admin/sign_out', to: 'admin/sessions#destroy'
  end
end