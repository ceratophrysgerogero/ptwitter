class UsersController < ApplicationController
  before_action :logged_in_user, only:[:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show 
    @user = User.find_by(id: params[:id])
    if logged_in? 
      @micropost = current_user.microposts.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create 
    cureate_user_name
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそPtwitterへ"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.microposts.each do | micropost |
      micropost.remove_pictures!
      micropost.save
    end
    
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "編集を保存しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  NOT_BLANK = /[^[:blank:]]+/
  def cureate_user_name
    user_name_scanned = params[:user][:name].scan(NOT_BLANK)
    user_name =""
    user_name_scanned.each_with_index do |name, index| 
      if index == 0
        user_name = name
      else
        user_name += "_"+name
      end
    end
    params[:user][:name] = user_name
  end
end
