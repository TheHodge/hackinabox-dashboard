class RenameCategoriesSubmissions < ActiveRecord::Migration
  def self.up
    rename_table :catergories_submissions, :categories_submissions
  end

  def self.down
    rename_table :categories_submissions, :catergories_submissions
  end
end
