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
    @todo_list = TodoList.find(params[:id])
    @user = @todo_list.user
    @incomplete_items = @todo_list.items.incomplete_and_ordered
    @completed_items = @todo_list.items.completed_and_ordered
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
