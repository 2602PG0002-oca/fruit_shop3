class MypageController < ApplicationController
  # ログインユーザのみアクセス許可
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin_flg)
  end
end