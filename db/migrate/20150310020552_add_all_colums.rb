class AddAllColums < ActiveRecord::Migration
  def change
    add_column :happenings, :name, :string
    add_column :happenings, :datetime, :datetime
    add_column :happenings, :info, :string
    add_column :happenings, :submitted_by, :integer
    add_column :happenings, :address, :string
    add_column :happenings, :city, :string
    add_column :happenings, :state, :string
    add_column :happenings, :zipcode, :string
  end
end
