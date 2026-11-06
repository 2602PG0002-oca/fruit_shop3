class ProductsController < ApplicationController
    # index・show以外は管理者のみ
  before_action :check_admin, except: [:index, :show]
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 商品一覧
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result
  end

    # 商品詳細
  def show
    @product = Product.find(params[:id])
  end

    # 商品編集
  def edit
    @product = Product.find(params[:id])
  end

  # 商品更新
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

    # 商品削除
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
        params.require(:product).permit(:name, :description, :price, :photo, :status)
  end

    # 管理者確認メソッド
  def check_admin
    unless current_user&.admin_flg
      redirect_to products_path, alert: '管理者権限が必要です。'
    end
  end

end