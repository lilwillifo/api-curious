require 'rails_helper'

describe GithubUser do
  let(:user){
    create(:user)
  }
  subject { GithubUser.new(user) }
  context 'initialize' do
    it 'exists with a valid state' do
      VCR.use_cassette("github-user-sees-profile") do
        expect(subject).to be_a GithubUser
      end
    end
  end

  context 'instance methods' do
    context '#commit_count' do
      it 'returns the number of recent commits' do
        VCR.use_cassette("github-user-sees-profile") do
          expect(subject.commit_count).to eq(16)
        end
      end
    end
    context '#repos' do
      it 'returns all the repos names and urls' do
        VCR.use_cassette("github-user-sees-repos") do
          expect(subject.repos).to be_an Array
          expect(subject.repos.first).to be_a Hash
          expect(subject.repos.first['name']).to be_a Hash
          expect(subject.repos.first['url']).to be_a Hash
        end
      end
    end
  end
end
