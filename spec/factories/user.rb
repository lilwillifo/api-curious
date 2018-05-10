FactoryBot.define do
  factory :user do
    name 'Margaret'
    nickname 'lilwillifo'
    uid '123'
    token ENV['TOKEN']
    avatar_url 'https://avatars.githubusercontent.com/u/33872479'
    follower_count 100
    following_count 15
  end
end
