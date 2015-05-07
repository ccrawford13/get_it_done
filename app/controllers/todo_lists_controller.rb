class TodoListsController < ApplicationController
  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = current_user.todo_lists.build( todo_list_params )
    @user = @todo_list.user
    @todo_list.save
  end

  def show
    @user = User.find(params[:user_id])
    @todo_list = @user.todo_lists
  end
  
  respond_to do |format|
    format.html
    format.js
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
