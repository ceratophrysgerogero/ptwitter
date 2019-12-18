class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  #ログインしてほしいところでログインチェックに使う
  def logged_in_user
    unless logged_in?
      store_url
      flash[:danger] ="ログインしてください"
      redirect_to login_url
    end
  end


end
