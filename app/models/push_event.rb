class PushEvent
  attr_reader :created_at, :repo_name, :commit_count
  def initialize(raw_event)
    @created_at = raw_event[:created_at]
    @repo_name = raw_event[:repo][:name]
    @commit_count = raw_event[:payload][:commits].count
  end
end
