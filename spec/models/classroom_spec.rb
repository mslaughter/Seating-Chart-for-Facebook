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
#  results      :string(255)     default("")
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe Classroom do
  pending "add some examples to (or delete) #{__FILE__}"
end
