class UsersController < ApplicationController
  def show
    @user = User.find_by_nickname(params[:nickname])
  end
end
