class User < ApplicationRecord

  def self.from_omniauth(auth)
    where(uid: auth[:uid]).first_or_create do |new_user|
      new_user.uid = auth[:uid].to_s,
      new_user.nickname = auth[:info][:nickname],
      new_user.name = auth[:info][:name],
      new_user.token = auth[:credentials][:token],
      new_user.avatar_url = auth[:extra][:raw_info][:avatar_url],
      new_user.follower_count = auth[:extra][:raw_info][:followers],
      new_user.following_count = auth[:extra][:raw_info][:following]
      # new_user.location = auth[:extra][:raw_info][:location],
      # new_user.repo_count = auth[:extra][:raw_info][:public_repos],
      # new_user.email = auth[:info][:email],
    end
  end

  def commit_count
    #make API call
    conn = Faraday.new(url: "https://api.github.com/users/#{nickname}/events")
    response = conn.get do |req|
      req.headers['Authorizations'] = ENV['token']
    end
    search = JSON.parse(response.body, symbolize_names: true)
    events = search.find_all do |event|
                    event[:type] == 'PushEvent'
                  end
    push_events = events.map do |raw_event|
      PushEvent.new(raw_event)
    end
    push_events.sum(&:commit_count)

    #iterate over commits and count recent (filter by date?)
  end

  def recent_commit_repos
    
  end
end

class PushEvent
  attr_reader :created_at, :repo_name, :commit_count
  def initialize(raw_event)
    @created_at = raw_event[:created_at]
    @repo_name = raw_event[:repo][:name]
    @commit_count = raw_event[:payload][:commits].count
  end
end
