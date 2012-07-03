# == Schema Information
#
# Table name: tables
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  classroom_id :integer
#  max_students :integer
#  students     :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe Table do
  pending "add some examples to (or delete) #{__FILE__}"
end
