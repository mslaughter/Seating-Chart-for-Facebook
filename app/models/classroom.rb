# == Schema Information
#
# Table name: classrooms
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  name         :string(255)
#  num_tables   :integer
#  num_students :integer
#  iterations   :integer
#  results      :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Classroom < ActiveRecord::Base
  attr_accessible :iterations, :name, :num_tables, :num_students
  
  belongs_to  :user
  has_many    :tables, dependent: :destroy
  has_many    :students, dependent: :destroy
  
  before_save :default_values
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :num_tables, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :num_students, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :iterations, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  def default_values
    self.iterations ||= 0
    self.num_tables ||= 0
    self.num_students ||= 0
  end
end
