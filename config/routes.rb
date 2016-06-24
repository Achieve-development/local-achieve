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

#カテゴリー登録機能
  resources :categories, only: [:index, :create, :destroy]

#プログラミング言語登録機能
  resources :languages, only: [:index, :create, :destroy]

#お問い合わせ投稿機能
  get 'contacts/new' => 'contacts#new'
  post 'contacts/new' => 'contacts#new'
  post 'contacts/confirm' => 'contacts#confirm'
  post 'contacts/create' => 'contacts#create'

#お問い合わせ受信機能
  get 'contacts/receive' => 'contacts#receive'

#フォローフォロワー機能
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end

end
