class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :logged_in_user

  protected
  def logged_in_user
    redirect_to root_url unless logged_in?
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end

  def authorize_user
    unless @user.is_user? current_user
      flash[:danger] = t :permission
      redirect_to root_url
    end
  end
end
