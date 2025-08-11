require "test_helper"

class AlertDeliveryTest < ActiveSupport::TestCase
  test "send notifications" do
    alert = alerts(:ethusdt)
    alert.update_columns(email_address: "test@test.test", webhook_url: "https://webhook.test.test")

    AlertDelivery.with(alert: alert).triggered.deliver_now

    assert_deliveries_via :mailer, :webhook
  end

  test "send only webhook if email is blank" do
    alert = alerts(:ethusdt)
    alert.update_columns(email_address: "", webhook_url: "https://webhook.test.test")

    AlertDelivery.with(alert: alert).triggered.deliver_now

    assert_deliveries_via_only :webhook
  end

  test "send only email if webhook url is blank" do
    alert = alerts(:ethusdt)
    alert.update_columns(email_address: "test@test.test", webhook_url: "")

    AlertDelivery.with(alert: alert).triggered.deliver_now

    assert_deliveries_via_only :mailer
  end
end
