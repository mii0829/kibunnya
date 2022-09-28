class AddFeelingIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :feeling_id, :integer
  end
end
