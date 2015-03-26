# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/confirm
  def confirm
    User.confirm
  end

  # Preview this email at http://localhost:3000/rails/mailers/user/welcome
  def welcome
    User.welcome
  end

end
