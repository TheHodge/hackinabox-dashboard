# == Schema Information
# Schema version: 20110727210105
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  
  has_and_belongs_to_many :submissions, :join_table => "categories_submissions"
  
  attr_accessible :name
  
  validates :name, :presence => true
  
end
