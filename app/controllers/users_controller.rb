class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # 如果访问的是 /profile，显示当前用户
    @user = params[:id] == "profile" ? current_user : User.find(params[:id])
  end
end
