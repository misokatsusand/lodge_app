class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/users/login_form")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "既にログインしています"
      redirect_to("/")
    end
  end

  def forbid_url
    flash[:notice] = "無効なURLです"
    redirect_to("/")
  end
end
