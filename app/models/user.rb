class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, format: /@/
  before_create :send_confirmation 

  # Token system based on Active Support Message Verifier
  # ref: http://ngauthier.com/2013/01/rails-unsubscribe-with-active-support-message-verifier.html
  def access_token
    User.create_access_token(self)
  end
  def self.verifier
    ActiveSupport::MessageVerifier.new(Rails.application.secrets[:secret_key_base])
  end
  def self.read_access_token(signature)
    email = verifier.verify(signature)
    User.where(email: email).last
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
  def self.create_access_token(user)
    verifier.generate(user.email)
  end

  private
    def send_confirmation
      UserMailer.confirm(self).deliver_now!
    rescue Net::SMTPServerBusy
      self.errors.add(:email, 'invalid. Unable to send confirmation to that address.')
      false
    end

end
