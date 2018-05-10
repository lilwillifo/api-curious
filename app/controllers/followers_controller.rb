class FollowersController < ApplicationController
  def index
    github_user = GithubUser.new(current_user.nickname)
    @followers = github_user.followers
  end
end
