class AddSingleAccessTokenToHackers < ActiveRecord::Migration
  def self.up
    add_column :hackers, :single_access_token, :string
  end

  def self.down
    remove_column :hackers, :single_access_token
  end
end
