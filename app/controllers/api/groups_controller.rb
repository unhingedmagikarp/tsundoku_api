class Api::GroupsController < ApplicationController
  before_action :authenticate_user

  def index
    groups = current_user.groups
    render json: groups
  end

  def create
    group = Group.new(group_params)
    if group.save
      group.users << current_user
      render json: group
    else
      render json: { data: 'error' }, status: 500
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
