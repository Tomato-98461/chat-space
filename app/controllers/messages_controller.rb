class MessagesController < ApplicationController
  def index
    @group = current_user.groups.find(params[:group_id])
    @messages = Message.where(group_id: params[:group_id])
    @message = Message.new
  end

  def create
    current_user.messages.create(message_params)
    redirect_to group_messages_path
  end

  private
  def message_params
    params.require(:message).permit(:message, :image).merge(group_id: params[:group_id])
  end
end
