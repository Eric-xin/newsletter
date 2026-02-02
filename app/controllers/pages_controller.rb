class PagesController < ApplicationController
  def index
    @site_name = Setting.get("site_name")
    @site_description = Setting.get("site_description")
  end
end
