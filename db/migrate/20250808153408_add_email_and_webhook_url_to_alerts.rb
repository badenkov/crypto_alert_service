class AddEmailAndWebhookUrlToAlerts < ActiveRecord::Migration[7.2]
  def change
    add_column :alerts, :email_address, :string
    add_column :alerts, :webhook_url, :string
  end
end
