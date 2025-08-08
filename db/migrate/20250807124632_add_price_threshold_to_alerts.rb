class AddPriceThresholdToAlerts < ActiveRecord::Migration[7.2]
  def change
    add_column :alerts, :price_threshold, :decimal
  end
end
