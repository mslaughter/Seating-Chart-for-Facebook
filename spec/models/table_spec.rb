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

require 'spec_helper'

describe Table do
  pending "add some examples to (or delete) #{__FILE__}"
end
