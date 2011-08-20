# == Schema Information
# Schema version: 20110731131045
#
# Table name: commits
#
#  id         :integer         not null, primary key
#  message    :string(255)
#  files      :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Commit < ActiveRecord::Base
  
  belongs_to :hacker, :class_name => "Hacker", :foreign_key => "user_id"
  
  validates :user_id, :presence => true
  
end
