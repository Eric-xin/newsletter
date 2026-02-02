module AdminAuthenticated
  extend ActiveSupport::Concern

  included do
    before_action :require_admin
    helper_method :current_admin
  end

  private

  def current_admin
    @current_admin ||= AdminUser.find_by(id: session[:admin_id])
  end

  def require_admin
    unless current_admin
      redirect_to login_path, alert: "Please log in to access the admin panel."
    end
  end
end
