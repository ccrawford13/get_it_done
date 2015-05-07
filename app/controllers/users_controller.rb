class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @todo_lists = @user.todo_lists
  end
end