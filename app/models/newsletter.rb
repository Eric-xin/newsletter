class Newsletter < ApplicationRecord
  validates :subject, presence: true
  validates :body, presence: true

  scope :public_newsletters, -> { where(is_public: true) }
  scope :sent, -> { where(status: "sent") }
  scope :draft, -> { where(status: "draft") }
  scope :sending, -> { where(status: "sending") }

  before_create :set_default_status

  def draft?
    status == "draft"
  end

  def sending?
    status == "sending"
  end

  def sent?
    status == "sent"
  end

  private

  def set_default_status
    self.status ||= "draft"
  end
end
