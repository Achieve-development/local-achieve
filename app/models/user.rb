class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :omniauthable

  #ユーザーとブログは１対多の関係・ユーザーが削除されたらそれにひも付くブログも削除される
  has_many :blogs, dependent: :destroy

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
  def find_for_twitter_oauth(auth, signed_in_resource=nil)
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

end
