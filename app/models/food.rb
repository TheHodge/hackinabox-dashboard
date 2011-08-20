# == Schema Information
# Schema version: 20110731110207
#
# Table name: foods
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  category   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Food < ActiveRecord::Base
  
  has_many :hackers
  
  validates :name, :presence => true
  validates :category, :presence => true
  
  scope :grouped, order("category")
  
  
end
