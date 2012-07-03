class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.integer :user_id
      t.string :name
      t.integer :num_tables
      t.integer :num_students
      t.integer :iterations
      t.string  :results, default: ""

      t.timestamps
    end
  end
end
