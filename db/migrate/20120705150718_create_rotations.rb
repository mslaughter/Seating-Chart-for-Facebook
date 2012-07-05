class CreateRotations < ActiveRecord::Migration
  def change
    create_table :rotations do |t|
      t.integer :name
      t.integer :classroom_id

      t.timestamps
    end
  end
end
