class Setting < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  DEFAULTS = {
    "smtp_address" => "",
    "smtp_port" => "587",
    "smtp_username" => "",
    "smtp_password" => "",
    "smtp_authentication" => "plain",
    "smtp_enable_starttls" => "true",
    "smtp_domain" => "",
    "from_email" => "",
    "from_name" => "Newsletter",
    "rate_limit" => "5",
    "rate_period" => "minute",
    "site_name" => "Newsletter",
    "site_description" => "Stay informed with our latest updates and announcements.",
    "unsubscribe_message" => "You are receiving this email because you subscribed to our newsletter."
  }.freeze

  def self.get(key)
    find_by(key: key)&.value || DEFAULTS[key.to_s]
  end

  def self.set(key, value)
    setting = find_or_initialize_by(key: key)
    setting.value = value
    setting.save!
  end

  def self.smtp_settings
    {
      address: get("smtp_address"),
      port: get("smtp_port").to_i,
      user_name: get("smtp_username"),
      password: get("smtp_password"),
      authentication: get("smtp_authentication"),
      enable_starttls_auto: get("smtp_enable_starttls") == "true",
      domain: get("smtp_domain")
    }
  end
end
