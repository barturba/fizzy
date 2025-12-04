class AddCancelAtToAccountSubscriptions < ActiveRecord::Migration[8.2]
  def change
    add_column :account_subscriptions, :cancel_at, :datetime
  end
end
