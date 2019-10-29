class GroupsController < ApplicationController

  def index
    @groups = current_user.groups.all
  end

  def new
    @group = Group.new
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").where.not(id: params[:user_ids])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group.id)
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    if @group.save
      redirect_to group_messages_path(@group)
    else
      render 'new'
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end
end
