class FollowingController < ApplicationController
  def index
    github_user = GithubUser.new(current_user.nickname)
    @following = github_user.following
  end
end
