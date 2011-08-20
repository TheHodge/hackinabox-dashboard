class CreateHackersTeams < ActiveRecord::Migration
  def self.up
    create_table :hackers_teams, :id => false do |t|
      t.integer :hacker_id
      t.integer :team_id
    end
  end

  def self.down
    drop_table :hackers_teams
  end
end
