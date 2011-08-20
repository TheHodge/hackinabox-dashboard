# == Schema Information
# Schema version: 20110802010628
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  hacker_id  :integer
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  
  belongs_to :hacker
  
  attr_accessible :content
  
  validates :hacker_id, :presence => true
  validates :content, :presence => true
  
  default_scope :order => 'microposts.created_at DESC', :limit => 10
  
end
