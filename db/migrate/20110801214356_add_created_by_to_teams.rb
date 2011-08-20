class AddCreatedByToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :created_by, :integer
  end

  def self.down
    remove_column :teams, :created_by
  end
end
