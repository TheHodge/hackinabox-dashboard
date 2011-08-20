class CreateCategorySubmissionTable < ActiveRecord::Migration
  def self.up
    create_table :catergories_submissions, :id => false do |t|
      t.integer :category_id
      t.integer :submission_id
    end
  end

  def self.down
    drop_table :catergories_submissions
  end
end
