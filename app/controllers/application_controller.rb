class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_notifications

  protect_from_forgery with: :exception


  def current_notifications
    if current_user.present?
      @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({message: [:conversation]})
      @notifications_count = Notification.where(recipient_id: current_user).order(created_at: :desc).unread.count
    end
  end

  PERMISSIBLE_ATTRIBUTES = %i(nick_name profile)

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.for(:account_update).push(PERMISSIBLE_ATTRIBUTES)
    end
end
