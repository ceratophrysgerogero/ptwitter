class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_to, only: destroy


  def create
    @micropost = current_user.microposts.build(microposts_strong_params)
    if @micropost.save 
      flash[:success] = "マイクロポストを作成しました！！"
      redirect_to root_url
    else
      @feed_itemes = []
      render 'home_pages/home'
    end
  end

  def destroy
    @micrtopost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def microposts_strong_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
