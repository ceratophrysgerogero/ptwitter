class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(microposts_strong_params)
    if @micropost.save 
      flash[:success] = "投稿に成功しました。"
      redirect_to user_path(params[:params_id])
    else
      @feed_items = []
      flash[:danger] = "投稿に失敗しました。"
      redirect_to user_path(params[:params_id])
    end
  end

  def destroy
    @micropost.remove_pictures!
    @micropost.save
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def microposts_strong_params
    params.require(:micropost).permit(:content, {pictures: []})
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
