class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:index,:account_edit,:profile_edit,:account_update,:profile_update,:destroy]}
  before_action :forbid_login_user, {only: [:new,:create,:login_form,:login]}
  before_action :forbid_url,{only: [:show,:edit,:update]}

  def index
    @administrator = "test@dummy.co.jp"
    if @current_user.email != @administrator
      flash[:notice] = "権限がありません"
      redirect_to "/"
    end
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    @user.icon_name = "default.jpg"
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザーを新規登録しました'
      redirect_to "/"
    else
      @name = params[:name]
      @email = params[:email]
      @password = params[:password]
      @user = User.new
      render "users/new"
    end
  end

  def account_edit
    @user = User.find(@current_user.id)
  end

  def account_update
    @user = User.find(@current_user.id)
    if @user.authenticate(params[:password_old])
      if @user.update(params.permit(:email, :password, :password_confirmation))
        flash[:notice] = "アカウント情報を更新しました"
        redirect_to "/"
      else
        render "users/account_edit"
      end
    else
      @error_message = "パスワードが間違っています"
      render "users/account_edit"
    end
  end

  def profile_edit
    @user = User.find(@current_user.id)
  end

  def profile_update #未実装
    @user = User.find(@current_user.id)
    if params[:icon_image]
      @user.icon_name = "#{@user.id}.jpg"
      image = params[:icon_image]
      File.binwrite("public/user_images/#{@user.icon_name}",image.read)
    else
      @user.icon_name = "default.jpg"
    end
    if @user.update(params.permit(:icon_name, :name, :introduce))
      flash[:notice] = "プロフィール情報を更新しました"
      redirect_to "/"
    else
      @user = User.find(@current_user.id)
      render "users/profile_edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました'
    redirect_to "/users/index"
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      flash[:notice] = "ログインしました"
      redirect_to "/"
    else
      @error_message = "メールアドレスかパスワードが存在しないか間違っています"
      @email = params[:email]
      @password = params[:password]
      @user = User.new
      render "users/login_form"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/users/login_form"
  end

  def show ;end
  def edit ;end
  def update ;end
end
