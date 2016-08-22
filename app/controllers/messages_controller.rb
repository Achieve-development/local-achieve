class MessagesController < ApplicationController
  before_action :find_conversation
  after_action :sending_pusher, only: [:create]

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
       @messages.last.read = true
      end
    end

    @message = @conversation.messages.build
  end



  def create
    @message = @conversation.messages.build(message_params)
    @notification = @message.notifications.build(recipient_id: @message.conversation.recipient_id, sender_id: @message.conversation.sender_id, conversation_id: @message.conversation_id)
    if @message.save
      Pusher["notifications"+@message.conversation.recipient_id.to_s].trigger("message", {messaging: "メッセージが届いています。：#{@message.body}"})
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
    if @conversation.sender != current_user
      @conversation.recipient_id = @conversation.sender_id
      @conversation.sender_id = current_user.id
    end
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def sending_pusher
    Notification.sending_pusher(@notification.recipient_id)
  end
end
