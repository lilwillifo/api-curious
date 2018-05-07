class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :screen_name
      t.string :uid
      t.string :oauth_token
      t.string :oauth_token_secret
    end
  end
end
