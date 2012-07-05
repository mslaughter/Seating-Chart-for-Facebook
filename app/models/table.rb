# == Schema Information
#
# Table name: tables
#
#  id           :integer         not null, primary key
#  name         :integer
#  classroom_id :integer
#  max_students :integer
#  students     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Table < ActiveRecord::Base
  attr_accessible :classroom_id, :max_students, :name
  
  belongs_to  :classroom
  belongs_to  :rotation
  has_many    :students
  
  validates :classroom_id, presence: true
  validates :max_students, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
