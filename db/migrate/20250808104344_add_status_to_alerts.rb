class AddStatusToAlerts < ActiveRecord::Migration[7.2]
  def change
    add_column :alerts, :status, :string, default: "pending", null: false
  end
end
