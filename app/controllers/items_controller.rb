class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @item = @todo_list.items.build( item_params )
    @item.save
      
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

  def item_params
    params.require(:item).permit(:title)
  end
end
