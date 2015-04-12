class CreateUserHappenings < ActiveRecord::Migration
  def change
    create_table :user_happenings do |t|
      t.string :name
      t.string :description
      t.string :start_time
      t.string :location

      t.timestamps null: true
    end
  end
end
