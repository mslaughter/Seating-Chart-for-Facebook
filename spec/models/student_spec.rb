# == Schema Information
#
# Table name: students
#
#  id                   :integer         primary key
#  classroom_id         :integer
#  name                 :string(255)
#  pin                  :boolean
#  pinned_table         :string(255)
#  students_sat_next_to :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe Student do
  pending "add some examples to (or delete) #{__FILE__}"
end
