class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @todo_lists = current_user.todo_lists
  end
end