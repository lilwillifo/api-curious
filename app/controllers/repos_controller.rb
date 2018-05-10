class ReposController < ApplicationController
  def index
    github_user = GithubUser.new(current_user.nickname)
    @repos = github_user.repos
  end
end
