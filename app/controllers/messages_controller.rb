class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    if @group.users.ids.include?(current_user.id)
      @messages = Message.where(group_id: @group.id)
      @message = Message.new
    else
      flash[:alert] = 'グループに参加しておりません。'
      redirect_to root_path
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(params[:group_id])  }
        format.json
      end
    else
      @messages = Message.where(group_id: params[:group_id])
      flash[:alert] = 'メッセージ投稿に失敗しました。'
      redirect_to group_messages_path
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :image).merge(group_id: params[:group_id])
  end
end
