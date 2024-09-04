Rails.application.routes.draw do

  devise_scope :user do
    post "/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root :to =>"homes#top"
    get '/about' => 'homes#about'
    get "/mypage" => "users#mypage"
    resources :users, except: [:new, :index, :create] do
      collection do
        patch :withdraw
        get :check
      end
    end
    resources :groups do
      resource :permits, only: [:create, :destroy]
      resources :group_users, only: [:show, :create, :destroy]
      resources :group_characters
      resources :messages, only: [:create, :destroy]
      collection do
        get 'play_character/:id', action: :play_character, as: 'play_character_with_id'
      end
    end
    get "groups/:id/permits" => "groups#permits", as: :permits
    resources :rooms, only: [:create, :index, :show] do
      resources :direct_messages, only: [:create, :destroy]
    end
    # mount ActionCable.server => '/cable'
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
      resources :group_characters, only: [:show, :destroy]
      resources :messages, only: [:destroy]
      collection do
        get 'play_character/:id', action: :play_character, as: 'play_character_with_id'
      end
    end
    resources :characters, only: [:index, :show, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    get "/search", to: "searches#search"
  end

  devise_scope :admin do
    get '/admin/sign_out', to: 'admin/sessions#destroy'
  end
end