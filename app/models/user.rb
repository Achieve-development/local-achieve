class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :omniauthable

  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy


  #ユーザーとフォローは１対多の関係・ユーザーが削除されたらそれにひも付くフォローの関係も削除される
  #has_many :relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destory

  #ユーザーとフォロワーは１対多の関係・ユーザーが削除されたらそれにひも付くフォロワーの関係も削除される
  #has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy

  #フォローとユーザーは
  #has_many :followed_users, through: :relationships, source: :followed

  #
  #has_many :followers, through: :reverse_relationships, source: :follower



  #Facebookからユーザーのデータを取得するメソッド
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user = User.new(
      user_name: auth.extra.raw_info.name,
      nick_name: auth.extra.raw_info.name,
      email: auth.info.email || User.create_unique_email,
      provider: auth.provider,
      uid: auth.uid,
      password: Devise.friendly_token[0,20]
    ) unless user

    #メールアドレスによる本人確認を飛ばす
    user.skip_confirmation!
    user.save
    user
  end

  # Twitterからユーザーのデータを取得するメソッド
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user = User.new(
      user_name: auth.info.nickname,
      nick_name: auth.info.nickname,
      email: User.create_unique_email,
      provider: auth.provider,
      uid: auth.uid,
      password: Devise.friendly_token[0,20]
    ) unless user

    #メールアドレスによる本人確認を飛ばす
    user.skip_confirmation!
    user.save
    user
  end

  #SNS認証の人がパスワードなしでログインできるようにする
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end


  #Twitter認証用にランダムな文字列を作成するメソッド
  def self.create_unique_string
    SecureRandom.uuid
  end

  #Twitter認証用に擬似的ななメールアドレスを作成するメソッド
  def self.create_unique_email
    User.create_unique_string + '@example.com'
  end

  #指定のユーザーをフォローするメソッド
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #指定のーザーのフォローを解除するメソッド
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  #フォローしているかどうかを確認
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  #「自分が」フォローしあっているユーザ一覧を取得する
  def friend
    User.from_users_followed_by(self)
  end

  #フォローしあっているユーザ一覧を取得する
  def self.from_users_followed_by(user)
    followed_user_ids =
    "SELECT X.id FROM (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = :user_id )
     X INNER JOIN 
    (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = :user_id )
    Y ON X.id = Y.id"
    where("id IN (#{followed_user_ids})", user_id: user.id)
  end

end
