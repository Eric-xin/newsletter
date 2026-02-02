class NewsletterSendJob < ApplicationJob
  queue_as :default

  def perform(newsletter_id)
    newsletter = Newsletter.find(newsletter_id)
    subscribers = Subscriber.active
    rate_limit = Setting.get("rate_limit").to_i
    rate_period = Setting.get("rate_period")

    sleep_time = case rate_period
    when "second" then 1.0 / rate_limit
    when "minute" then 60.0 / rate_limit
    when "hour"   then 3600.0 / rate_limit
    else 60.0 / rate_limit
    end

    ActionMailer::Base.smtp_settings = Setting.smtp_settings

    subscribers.find_each do |subscriber|
      NewsletterMailer.send_newsletter(newsletter, subscriber).deliver_now
      sleep(sleep_time)
    end

    newsletter.update!(status: "sent", sent_at: Time.current)
  rescue => e
    Rails.logger.error("Newsletter send failed: #{e.message}")
    newsletter&.update(status: "draft")
    raise
  end
end
