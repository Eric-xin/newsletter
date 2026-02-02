class AnnouncementsController < ApplicationController
  def index
    @newsletters = Newsletter.public_newsletters.sent.order(sent_at: :desc)
    @site_name = Setting.get("site_name")
  end

  def show
    @newsletter = Newsletter.public_newsletters.sent.find(params[:id])
    @site_name = Setting.get("site_name")
  end
end
