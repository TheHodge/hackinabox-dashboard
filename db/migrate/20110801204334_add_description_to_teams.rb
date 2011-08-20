class AddDescriptionToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :description, :text
  end

  def self.down
    remove_column :teams, :description
  end
end
