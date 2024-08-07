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
    resources :groups, except: [:new]
    resources :posts, except: [:new]
    resources :characters
    resources :group_characters, except: [:new, :show, :edit]
    resources :schedules, except: [:index]
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
    resources :posts, only: [:index, :destroy]
    resources :groups, only: [:show, :index, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end

  devise_scope :admin do
    get '/admin/sign_out', to: 'admin/sessions#destroy'
  end
end