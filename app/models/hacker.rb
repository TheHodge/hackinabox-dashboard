# == Schema Information
# Schema version: 20110802002933
#
# Table name: hackers
#
#  id                  :integer         not null, primary key
#  email               :string(255)     not null
#  name                :string(255)
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  perishable_token    :string(255)     not null
#  current_login_at    :datetime
#  last_login_at       :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  food_id             :integer
#  description         :text
#  admin               :boolean
#  single_access_token :string(255)
#

class Hacker < ActiveRecord::Base
  
  has_and_belongs_to_many :teams
  has_many :submissions, :through => :teams
  belongs_to :food
  has_many :microposts, :dependent => :destroy
  has_many :commits, :class_name => "commit", :foreign_key => "user_id"
  
  attr_accessible :name, :email, :description, :password, :password_confirmation, :food_id, :requirments
  
  acts_as_authentic
  
end
