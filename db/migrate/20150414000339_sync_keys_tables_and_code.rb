class SyncKeysTablesAndCode < ActiveRecord::Migration
  def change
    remove_column :user_happenings, :location, :string
    add_column :user_happenings, :address, :string
    remove_column :user_happenings, :start_time, :string
    add_column :user_happenings, :start_time, :datetime
  end
end
