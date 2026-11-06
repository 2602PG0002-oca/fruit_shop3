class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart
    cart_item = cart.cart_items.find_by(product_id: cart_item_params[:product_id])

    if cart_item
      cart_item.quantity += cart_item_params[:quantity].to_i
    else
      cart_item = cart.cart_items.new(cart_item_params)
    end

    if cart_item.save
      redirect_to cart_path(current_user.cart), notice: '商品がカートに追加されました。'
    else
      redirect_to products_path, notice: '商品をカートに追加できませんでした。'
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_path(current_user.cart), notice: '商品数量が更新されました。'
    else
      redirect_to cart_path(current_user.cart), notice: '商品数量の更新に失敗しました。'
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to cart_path(current_user.cart), notice: '商品がカートから削除されました。'
    else
      redirect_to cart_path(current_user.cart), notice: '商品をカートから削除できませんでした。'
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end