module ActiveDeliveryTestHelpers
  extend ActiveSupport::Concern

  included do
    setup do
      ActiveDelivery::TestDelivery.store.clear
      ActiveDelivery::TestDelivery.lines.clear
      AbstractNotifier::Testing::Driver.deliveries.clear
    end
  end

  def assert_deliveries_via(*expected_channels)
    actual = ActiveDelivery::TestDelivery.lines
    missing = expected_channels - actual

    assert missing.empty?,
           "Expected deliveries via #{expected_channels.inspect}, " \
           "but missing #{missing.inspect}. Actual: #{actual.inspect}"
  end

  def assert_deliveries_via_only(*expected_channels)
    actual = ActiveDelivery::TestDelivery.lines
    assert_equal expected_channels.sort, actual.sort,
                 "Expected deliveries via only #{expected_channels.inspect}, " \
                 "but got #{actual.inspect}"
  end
end
