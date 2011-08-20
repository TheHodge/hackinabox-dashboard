class AddTeamIdToSubmissions < ActiveRecord::Migration
  def self.up
    add_column :submissions, :team_id, :integer
  end

  def self.down
    remove_column :submissions, :team_id
  end
end
