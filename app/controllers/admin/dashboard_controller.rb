module Admin
  class DashboardController < ApplicationController
    include AdminAuthenticated
    layout "admin"

    def index
      @total_subscribers = Subscriber.active.count
      @total_newsletters = Newsletter.count
      @sent_newsletters = Newsletter.sent.count
      @recent_newsletters = Newsletter.order(created_at: :desc).limit(5)
    end
  end
end
