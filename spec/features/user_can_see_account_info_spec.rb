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

feature 'User sees their basic account info' do
  include Capybara::DSL
  before(:each) do
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end
  scenario 'User sees profile pic, number of starred repos, followers, following' do
    visit root_path
    expect(page.status_code).to eq(200)

    click_link "Sign in with Github"
    expect(current_path).to eq('/lilwillifo')
    expect(page).to have_content('Margaret')
    expect(page).to have_link('Logout')

    expect(page).to have_css("img[src*=\"#{stub_omniauth[:extra][:raw_info][:avatar_url]}\"]")

    expect(page).to have_content(stub_omniauth[:extra][:raw_info][:followers])
    expect(page).to have_content(stub_omniauth[:extra][:raw_info][:following])

  end
end
