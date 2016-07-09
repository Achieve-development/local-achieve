class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :language

  has_many :answers, dependent: :destroy #質問が消えたらアンサーも消える
end
