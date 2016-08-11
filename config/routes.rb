Rails.application.routes.draw do

#トップ画面
  root 'top#index'

#ログイン機能・SNS認証機能
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

#ブログ投稿機能（コメントも投稿できるようにする）
  resources :blogs do
    resources :comments
  end

  resources :relationships, only: [:create, :destroy]

#Q&A機能
  resources :questions do
    resources :answers
  end

#お問い合わせ投稿機能
  resources :contacts, only: [:new, :create]
  post 'contacts/new' => 'contacts#new'
  post 'contacts/confirm' => 'contacts#confirm'

#お問い合わせ受信機能
  get 'contacts/receive' => 'contacts#receive'

#フォローフォロワー機能
  resources :users, only: [:index, :show, :edit, :update] do
    resources :tasks
    resources :submit_requests, shallow: true do
      get 'approve'
      get 'unapprove'
      get 'reject'
      collection do
        get 'inbox'
      end
    end
    resources :notifications, only: [:index]
    member do
      get :following, :followers
    end
  end

#会話機能
  resources :conversations do
    resources :messages
  end

#カテゴリー登録機能
  resources :categories, only: [:index, :create, :destroy]

#プログラミング言語登録機能
  resources :languages, only: [:index, :create, :destroy]

end
