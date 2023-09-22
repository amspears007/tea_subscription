class AddStatustoSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :status, :integer, default: 0
  end
end
