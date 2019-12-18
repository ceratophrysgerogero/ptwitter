class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]


  def create
    @micropost = current_user.microposts.build(microposts_strong_params)
    if @micropost.save 
      flash[:success] = "マイクロポストを作成しました！！"
      redirect_to root_url
    else
      render 'home_pages/home'
    end
  end

  def destroy
  end

  private

  def microposts_strong_params
    params.require(:micropost).permit(:content)
  end
end
