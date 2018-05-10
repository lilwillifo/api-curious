class GithubUser
  attr_reader :nickname
  def initialize(nickname)
    @github_service = GithubService.new
    @nickname = nickname
  end

  def commit_count
    push_events.sum(&:commit_count)
  end

  def repos
    github_service.get_url("users/#{nickname}/repos?per_page=100").map do |raw_repo|
      Repo.new(raw_repo)
    end
  end

  def followers
    github_service.get_url("users/#{nickname}/followers?per_page=100").map do |raw_follower|
      GithubUser.new(raw_follower[:login])
    end
  end

  def following
    github_service.get_url("users/#{nickname}/following?per_page=100").map do |raw_follower|
      GithubUser.new(raw_follower[:login])
    end
  end

  private
  attr_reader :github_service

  def push_events
    raw_push_events.map do |raw_event|
      PushEvent.new(raw_event)
    end
  end

  def raw_push_events
    github_service.get_url("users/#{nickname}/events").find_all do |event|
      event[:type] == 'PushEvent'
    end
  end
end
