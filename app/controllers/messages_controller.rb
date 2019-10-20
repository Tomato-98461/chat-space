class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @messages = Message.where(group_id: params[:group_id])
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path, notice: '送信完了'
    else
      @messages = Message.where(group_id: params[:group_id])
      flash[:alert] = 'メッセージを入力してください。'
      redirect_to group_messages_path
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :image).merge(group_id: params[:group_id])
  end
end
