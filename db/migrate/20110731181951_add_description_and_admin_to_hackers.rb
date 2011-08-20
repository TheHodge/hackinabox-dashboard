class AddDescriptionAndAdminToHackers < ActiveRecord::Migration
  def self.up
    add_column :hackers, :description, :text
    add_column :hackers, :admin, :boolean
    remove_column :hackers, :gitemail
  end

  def self.down
    remove_column :hackers, :admin
    remove_column :hackers, :description
    add_column :hackers, :gitemail, :string
  end
end
