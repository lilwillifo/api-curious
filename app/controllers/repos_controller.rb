class ReposController < ApplicationController
  def index
    github_user = GithubUser.new(current_user)
    @repos = github_user.repos
  end
end
