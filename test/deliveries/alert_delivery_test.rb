require "test_helper"

class AlertDeliveryTest < ActiveSupport::TestCase
  test "test" do
    alert = alerts(:ethusdt)

    # ActiveDelivery::TestDelivery.enable do
    assert_delivery_enqueued(AlertDelivery, :triggered, count: 1) do
      AlertDelivery.with(alert:).triggered.deliver_later
    end

    s = ActiveDelivery::TestDelivery.store
    l = ActiveDelivery::TestDelivery.lines

    # binding.irb
  end
end
