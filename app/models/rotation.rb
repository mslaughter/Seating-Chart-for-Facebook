# == Schema Information
#
# Table name: rotations
#
#  id           :integer         not null, primary key
#  name         :integer
#  classroom_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Rotation < ActiveRecord::Base
  attr_accessible :classroom_id, :name
  
  belongs_to  :classroom
  has_many    :tables
  
  validates :name, presence: true
  validates :classroom_id, presence: true
end
