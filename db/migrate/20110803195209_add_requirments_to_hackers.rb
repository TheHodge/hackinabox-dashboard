class AddRequirmentsToHackers < ActiveRecord::Migration
  def self.up
    add_column :hackers, :requirments, :text
  end

  def self.down
    remove_column :hackers, :requirments
  end
end
