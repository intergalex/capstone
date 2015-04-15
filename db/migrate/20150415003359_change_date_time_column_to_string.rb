class ChangeDateTimeColumnToString < ActiveRecord::Migration
  def change
    change_column :user_happenings, :start_time, :string
  end
end
