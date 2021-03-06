class ProductsController < ApplicationController
  before_action :set_product, except: [:new, :create, :index]
  before_action :authorize_vendor!, except: [:index, :show]
  skip_before_action :authentication_required, only: [:index, :show]

  def index
    @products = Product.active_products
    @tags = Tag.all
  end

  def show
    @seller ||= User.find(@product.seller_id)
    if session[:user_id]
      @user = User.find(session[:user_id])
      @order = @user.orders.last
    end
  end 

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_hash)
    @product.seller_id = session[:user_id]
    @product.save

    if @product
      redirect_to(@product)
    else
      render :edit
    end
  end

  def update
    @user = User.find(@product.seller_id)
    if @product.update(product_hash)
      redirect_to(@user) # 'My Products' tab on user show page?
    else
      render :edit
    end
  end

  def destroy
    @product.seller_id = nil
    @product.save

    respond_to do |format|
      format.html 
      format.js
    end
  end 

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_hash
      params.require(:product).permit(:title, :price_dollars, :description, :quantity, :product_image, tag_ids: [], tags_attributes: [:name])
    end

    def authorize_vendor!
      authentication_required
      unless current_user.vendor?
        flash[:notice] = "You must be a vendor to do that."
        redirect_to root_path
      end 
    end 

end