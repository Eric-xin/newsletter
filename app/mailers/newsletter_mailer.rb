class NewsletterMailer < ApplicationMailer
  def send_newsletter(newsletter, subscriber)
    @newsletter = newsletter
    @subscriber = subscriber
    @unsubscribe_url = unsubscribe_url(token: subscriber.token)
    @unsubscribe_message = Setting.get("unsubscribe_message")

    mail(
      to: subscriber.email,
      subject: newsletter.subject,
      from: "#{Setting.get('from_name')} <#{Setting.get('from_email')}>"
    )
  end
end
