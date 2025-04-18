class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 注册后跳转到登录页面
  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  # 登录后跳转到个人页面
  def after_sign_in_path_for(resource)
    posts_path
  end
  

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end
end
