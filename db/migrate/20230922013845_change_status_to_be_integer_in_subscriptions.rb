class ChangeStatusToBeIntegerInSubscriptions < ActiveRecord::Migration[5.2]
  def up
    remove_column :subscriptions, :status
  end

  def down
    add_column :subscriptions, :status, :integer, default: 0
  end
end
