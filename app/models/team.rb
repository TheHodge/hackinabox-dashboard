# == Schema Information
# Schema version: 20110802002933
#
# Table name: teams
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  permalink   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  created_by  :integer
#

class Team < ActiveRecord::Base
  
  has_and_belongs_to_many :hackers
  has_many :submissions
  belongs_to :hacker, :foreign_key => :created_by
  
  attr_accessible :name, :description, :hacker_ids, :created_by
  
  HUMANIZED_ATTRIBUTES = {
    :hacker_ids => ""
  }

  def self.human_attribute_name(attr,options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  validates :name,  :presence => true,
                    :uniqueness => true
  
  before_save :set_permalink

  def set_permalink
    self.permalink = name.parameterize
  end

  def to_param
    permalink
  end
end
