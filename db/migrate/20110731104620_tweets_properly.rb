class TweetsProperly < ActiveRecord::Migration
  def self.up
    drop_table :tweets
    create_table :tweets do |t|
       t.string :username
       t.string :body
       t.string :avatar_url
       t.integer :status_id
       t.timestamps
     end
  end

  def self.down
       drop_table :tweets
  end
end
