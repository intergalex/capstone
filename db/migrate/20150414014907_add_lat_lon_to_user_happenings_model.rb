class AddLatLonToUserHappeningsModel < ActiveRecord::Migration
  def change
    add_column :user_happenings, :latitude, :float
    add_column :user_happenings, :longitude, :float
  end
end
