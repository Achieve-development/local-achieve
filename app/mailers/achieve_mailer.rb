class AchieveMailer < ApplicationMailer

  def answer_send(answer)
    @who_questioned = answer.question.user
    @who_answered = answer.user
    @answer = answer.content
    mail to: @who_questioned.email
  end
end
