# == Schema Information
#
# Table name: students
#
#  id                   :integer         not null, primary key
#  classroom_id         :integer
#  name                 :string(255)
#  pin                  :boolean         default(FALSE)
#  pinned_table         :integer
#  students_sat_next_to :string(255)     default("")
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

require 'spec_helper'

describe Student do
  pending "add some examples to (or delete) #{__FILE__}"
end
