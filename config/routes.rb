Rails.application.routes.draw do
  
  # ユーザー用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :public do
    get '/' => 'homes#top'
    get '/about' => 'homes#about'
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
  end

  devise_scope :admin do
    get '/admin/sign_out', to: 'admin/sessions#destroy'
  end
end