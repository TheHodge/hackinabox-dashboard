class ChangeStatusidToBigintInTweets < ActiveRecord::Migration
  def self.up
    change_table :tweets do |t|
      t.change :status_id, :bigint
    end
  end

  def self.down
    change_table :tweets do |t|
      t.change :status_id, :int
    end
  end
end
