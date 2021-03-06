class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({message: [:conversation]})
    @notifications.update_all(read: true)
  end
end
