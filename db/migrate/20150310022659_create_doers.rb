class CreateDoers < ActiveRecord::Migration
  def change
    create_table :doers do |t|
      t.string :username
      t.string :email
      t.string :happening_id
      t.datetime :join

      t.timestamps null: true
    end
  end
end
