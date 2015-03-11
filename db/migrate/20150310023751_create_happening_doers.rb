class CreateHappeningDoers < ActiveRecord::Migration
  def change
    create_table :happening_doers do |t|
      t.integer :happening_id
      t.integer :doer_id

      t.timestamps null: true
    end
  end
end
