Rails.application.routes.draw do

  resources :comments
#トップ画面
  root 'top#index'

#ブログ投稿機能（コメントも投稿できるようにする）
  resources :blogs do
    resources :comments
  end

#お問い合わせ投稿機能
  get 'contacts/new' => 'contacts#new'
  post 'contacts/new' => 'contacts#new'
  post 'contacts/confirm' => 'contacts#confirm'
  post 'contacts/create' => 'contacts#create'

#お問い合わせ受信機能
  get 'contacts/receive' => 'contacts#receive'

#ログイン機能

#ログイン機能


end
