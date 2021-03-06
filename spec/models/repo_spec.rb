require 'rails_helper'

describe Repo do
  let(:raw_repo) {
    {
      name: 'activerecord_exploration',
      html_url: 'https://github.com/lilwillifo/activerecord_exploration'
    }

  }
  subject { Repo.new(raw_repo) }
  context 'initialize' do
    it 'returns valid attributes' do
      expect(subject).to be_a Repo
      expect(subject.name).to eq(raw_repo[:name])
      expect(subject.url).to eq(raw_repo[:html_url])
    end
  end
end
