class CreateHappenings < ActiveRecord::Migration
  def change
    create_table :happenings do |t|
      t.string :name
      t.string :description
      t.string :location
      t.string :start_time

      t.timestamps null: false
    end
  end
end
