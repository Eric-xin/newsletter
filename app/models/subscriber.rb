class Subscriber < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_create :generate_token
  before_create :set_subscribed_at

  scope :active, -> { where(unsubscribed_at: nil) }

  def unsubscribe!
    update!(unsubscribed_at: Time.current)
  end

  def active?
    unsubscribed_at.nil?
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
  end

  def set_subscribed_at
    self.subscribed_at ||= Time.current
  end
end
