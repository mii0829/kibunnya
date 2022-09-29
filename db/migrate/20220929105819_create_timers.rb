class CreateTimers < ActiveRecord::Migration[6.1]
  def change
    create_table :timers do |t|
      t.string :name
      t.timestamps null: false
    end 
  end
end
