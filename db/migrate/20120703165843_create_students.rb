class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer   :classroom_id
      t.integer   :table_id
      t.string    :name
      t.boolean   :pin, default: false
      t.integer   :pinned_table
      t.string    :students_sat_next_to, default: ""
      
      t.timestamps
    end
  end
end
