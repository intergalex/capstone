class CreateHappenings < ActiveRecord::Migration
  def change
    create_table :happenings do |t|

      t.timestamps null: true
    end
  end
end
