require "net/smtp"

module Admin
  class SettingsController < ApplicationController
    include AdminAuthenticated
    layout "admin"

    def index
      @settings = {}
      Setting::DEFAULTS.each_key do |key|
        @settings[key] = Setting.get(key)
      end
    end

    def update
      params[:settings]&.each do |key, value|
        Setting.set(key, value) if Setting::DEFAULTS.key?(key)
      end
      redirect_to admin_settings_path, notice: "Settings saved."
    end

    def test_smtp
      begin
        smtp = Net::SMTP.new(Setting.get("smtp_address"), Setting.get("smtp_port").to_i)
        smtp.enable_starttls_auto if Setting.get("smtp_enable_starttls") == "true"
        smtp.open_timeout = 10
        smtp.read_timeout = 10
        smtp.start(Setting.get("smtp_domain").presence || "localhost", Setting.get("smtp_username"), Setting.get("smtp_password"), Setting.get("smtp_authentication").to_sym) do |s|
          # Connection successful
        end
        render json: { success: true, message: "SMTP connection successful!" }
      rescue => e
        render json: { success: false, message: "SMTP connection failed: #{e.message}" }
      end
    end
  end
end
