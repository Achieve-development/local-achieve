class Contact < ActiveRecord::Base

  #メールアドレスの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #バリデーション
  validates :name, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
  validates :message, presence: true
end
