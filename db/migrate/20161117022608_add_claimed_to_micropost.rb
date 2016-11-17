class AddClaimedToMicropost < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :claimed, :integer
  end
end
