class DestroyHappeningIdInDoerTable < ActiveRecord::Migration
  def change
    remove_column :doers, :happening_id, :string
  end
end
