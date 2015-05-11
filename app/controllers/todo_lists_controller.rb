class TodoListsController < ApplicationController
  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = current_user.todo_lists.build( todo_list_params )
    @todo_list.save
    @user = @todo_list.user
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    # @user = User.find(params[:user_id])
    # @todo_lists = @user.todo_lists
    @todo_list = TodoList.find(params[:id])
    @items = @todo_list.items
  end

  def destroy
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end

  

  private

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
