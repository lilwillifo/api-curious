class GithubUsersController < ApplicationController
  def show
    @github_user = GithubUser.new(params[:nickname])
  end
end
