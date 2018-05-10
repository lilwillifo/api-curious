require 'rails_helper'

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] =
    OmniAuth::AuthHash.new(
      {"uid"=>"33872479",
       "info"=> {
          "nickname"=>"lilwillifo",
          "email"=>"margaretwilliford4@gmail.com",
          "name"=>"Margaret",
          "urls"=> {"GitHub"=>"https://github.com/lilwillifo", "Blog"=>""}
        },
        "credentials"=>{"token"=>ENV['TOKEN']},
        "extra"=>
        {
          "raw_info"=>
          {
             "avatar_url"=>'https://avatars3.githubusercontent.com/u/33872479?v=4',
             "public_repos"=>39,
             "followers"=>2,
             "following"=>1,
          }
        }
      })
    end

feature 'User sees their repo names and URLs on repos index' do
  include Capybara::DSL
  before(:each) do
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end
  scenario 'User can link from root page' do
    VCR.use_cassette("github-user-sees-profile-information") do
      visit root_path

      click_link "Sign in with Github"
      click_link '39 Repositories'
    end
    VCR.use_cassette("user-sees-repo-index") do
      expect(current_path).to eq("/lilwillifo/repos")
      expect(page).to have_content('Name')
      expect(page).to have_content('URL')
    end
  end
end
