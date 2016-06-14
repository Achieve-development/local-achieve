# Preview all emails at http://localhost:3000/rails/mailers/achieve_mailer
class AchieveMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/achieve_mailer/answer_send
  def answer_send
    AchieveMailer.answer_send
  end

end
