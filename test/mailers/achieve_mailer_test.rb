require 'test_helper'

class AchieveMailerTest < ActionMailer::TestCase
  test "answer_send" do
    mail = AchieveMailer.answer_send
    assert_equal "Answer send", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
