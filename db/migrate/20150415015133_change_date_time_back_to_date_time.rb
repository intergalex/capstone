class ChangeDateTimeBackToDateTime < ActiveRecord::Migration
  def change
    change_column :user_happenings, :start_time, :datetime
  end

end
