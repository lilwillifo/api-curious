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
end
