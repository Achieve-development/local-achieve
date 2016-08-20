class Notification < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::DateHelper

  belongs_to :sender, class_name: "Conversation", foreign_key: :sender_id
  belongs_to :recipient, class_name: "Conversation", foreign_key: :recipient_id
  belongs_to :message, class_name: "Message", foreign_key: :message_id
  belongs_to :conversation

  scope :read, -> { where(read: true) }
  scope :unread, -> { where(read: false) }
  scope :unread_count, -> (user_id) { where(recipient_id: user_id).unread.count }

  def self.sending_pusher(channel_user_id)
    Pusher.trigger("notifications#{channel_user_id}", 'message', {
      unread_count: Notification.unread_count(channel_user_id)
    })
  end
end
