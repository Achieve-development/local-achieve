class Blog < ActiveRecord::Base
  #ブログとユーザーは１対多の関係
  belongs_to :user
  #ブログとコメントは１対多の関係
  has_many :comments
end
