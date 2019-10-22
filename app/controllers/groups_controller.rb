class GroupsController < ApplicationController

  def index
    @groups = current_user.groups.all
  end

  def new
    @group = Group.new
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%")
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path
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
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end
end
