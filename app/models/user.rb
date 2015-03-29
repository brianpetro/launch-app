class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, format: /@/
  validates_uniqueness_of :email
  before_create :send_welcome
  after_create :send_confirmation 

  # Token system based on Active Support Message Verifier
  # ref: http://ngauthier.com/2013/01/rails-unsubscribe-with-active-support-message-verifier.html
  def access_token
    User.create_access_token(self)
  end
  def self.verifier
    ActiveSupport::MessageVerifier.new(Rails.application.secrets[:secret_key_base])
  end
  def self.read_access_token(signature)
    id = verifier.verify(signature)
    User.find id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
  def self.create_access_token(user)
    verifier.generate(user.id)
  end

  private
    def send_confirmation
      UserMailer.confirm(self).deliver_now!
    end
    def send_welcome
      UserMailer.welcome(self).deliver_now!
    rescue Net::SMTPServerBusy
      self.errors.add(:email, 'invalid. Unable to send emails to that address.')
      false
    end

end
