require 'rails_helper'

describe PushEvent do
  let(:raw_event) {
    {
      created_at: "2018-05-08T23:18:31Z",
      repo: {name: 'lilwillifo/api-curious'},
      payload: {commits: [{:sha=>"493b925bc2b360904b24965e20c96455413d7d5b",
                            :author=>{:email=>"margaretwilliford4@gmail.com", :name=>"Margaret Williford"},
                            :message=>"sessions controller",
                            :distinct=>false,
                            :url=>"https://api.github.com/repos/lilwillifo/api-curious/commits/493b925bc2b360904b24965e20c96455413d7d5b"},
                           {:sha=>"0eec554e94e349947f241ecfec74cd9df0203e81",
                            :author=>{:email=>"margaretwilliford4@gmail.com", :name=>"Margaret Williford"},
                            :message=>"adding user table",
                            :distinct=>false,
                            :url=>"https://api.github.com/repos/lilwillifo/api-curious/commits/0eec554e94e349947f241ecfec74cd9df0203e81"}
                          ]}
    }
  }
  subject { PushEvent.new(raw_event) }

  context 'initialize' do
    it 'exists with a valid event' do
      expect(subject).to be_a PushEvent
      expect(subject.created_at).to eq(raw_event[:created_at])
      expect(subject.repo_name).to eq(raw_event[:repo][:name])
      expect(subject.commit_count).to eq(raw_event[:payload][:commits].count)
    end
  end
end
