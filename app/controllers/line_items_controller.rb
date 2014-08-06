class LineItemsController < ApplicationController

  def create
    # redirect_to "auth/amazon" unless params[:line_item][:order_id]
    @line_item = LineItem.create(lineitem_params)
    @order = @line_item.order
    @user = User.find(@order.buyer_id)

    if @line_item
      redirect_to(user_order_path(@user, @order))
    else
      render :edit
    end

  end 

  def destroy
    @line_item = LineItem.find(params[:id])
    @order = Order.find(@line_item.order_id) 
    @user = User.find(session[:user_id])
    @line_item.destroy

    redirect_to :back
  end




  private
   def lineitem_params
      params.require(:line_item).permit(:item_id, :order_id)
    end




end
