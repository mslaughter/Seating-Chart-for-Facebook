class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :name
      t.integer :classroom_id
      t.integer :max_students
      t.string  :students
      t.integer :rotation_id

      t.timestamps
    end
  end
end
