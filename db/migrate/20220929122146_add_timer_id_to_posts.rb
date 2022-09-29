class AddTimerIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :timer_id, :integer
  end
end
