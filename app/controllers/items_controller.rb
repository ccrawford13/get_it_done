class ItemsController < ApplicationController
  
  before_action :find_todo_list, except: [:new]

  def new
    @item = Item.new
  end

  def create
    @item = @todo_list.items.build( item_params )
    @item.save
      
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.mark_complete

    respond_to do |format|
      format.html
      format.js
    end
  end

  # def destroy
    
  #   @item = Item.find(params[:id])

  #   @item.destroy

  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end

  private

  def find_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def item_params
    params.require(:item).permit(:title)
  end
end
