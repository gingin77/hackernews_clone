class UsersController < ApplicationController
  def show
  end

  private

  def user
    @user ||= User.find_by(name: params[:id])
  end
  helper_method :user

end
