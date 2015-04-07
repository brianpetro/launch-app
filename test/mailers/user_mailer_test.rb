require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "send confirmation email" do
    user = users(:one)
    mail = UserMailer.confirm(user)
    assert_equal I18n.t('user_mailer.confirm.subject'), mail.subject
    assert_equal [user.email], mail.to
    assert_equal [ENV['FROM_EMAIL']], mail.from
    #assert_match "Hi", mail.body.encoded
  end

  test "send welcome email" do
    user = users(:one)
    mail = UserMailer.welcome(user)
    assert_equal I18n.t('user_mailer.welcome.subject'), mail.subject
    assert_equal [user.email], mail.to
    assert_equal [ENV['FROM_EMAIL']], mail.from
    #assert_match "Hi", mail.body.encoded
  end

end
