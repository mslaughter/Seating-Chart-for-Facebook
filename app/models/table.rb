# == Schema Information
#
# Table name: tables
#
#  rotation_id  :integer
#  id           :integer         primary key
#  name         :integer
#  classroom_id :integer
#  max_students :integer
#  students     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Table < ActiveRecord::Base
  attr_accessible :classroom_id, :max_students, :name, :students
  
  belongs_to  :classroom
  belongs_to  :rotation
  
  before_save :default_values
  
  validates :max_students, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  def default_values
    self.students ||= ""
  end
end
