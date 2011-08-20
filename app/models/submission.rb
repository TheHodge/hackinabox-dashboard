# == Schema Information
# Schema version: 20110727225942
#
# Table name: submissions
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  description            :text
#  url                    :string(255)
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer
#  thumbnail_updated_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  team_id                :integer
#

class Submission < ActiveRecord::Base
  
  belongs_to :team
  belongs_to :hacker
  has_many :hackers, :through => :team
  has_and_belongs_to_many :categories, :join_table => "categories_submissions"
  
  attr_accessible :name, :description, :url, :thumbnail, :team_id, :category_ids
  
  HUMANIZED_ATTRIBUTES = {
    :category_ids => "",
    :team_id => ""
  }
  
  def self.human_attribute_name(attr,options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  has_attached_file :thumbnail, :styles => { :medium => "300x300>",:path => "/public/uploads/", :thumb => "100x100>" }
  validates_attachment_size :thumbnail, :less_than => 1.megabytes
  validates_attachment_content_type :thumbnail, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']
  
  validates :name, :presence => true
  validates :description, :presence => true
  validates :team_id, :presence => {:message => "A team must be selected"}
  validates :category_ids, :length => {:minimum => 1, :message => "At least one category must be selected"} 
  
end
