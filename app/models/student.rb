# == Schema Information
#
# Table name: students
#
#  id                   :integer         primary key
#  classroom_id         :integer
#  name                 :string(255)
#  pin                  :boolean
#  pinned_table         :integer
#  students_sat_next_to :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class Student < ActiveRecord::Base
  attr_accessible :classroom_id, :name, :pin, :pinned_table
  
  belongs_to  :classroom
  
  before_save :default_values
  
  validates :name, presence: true
  validates :classroom_id, presence: true
  
  def default_values
    self.students_sat_next_to ||= ""
    self.pin ||= false
  end
end
