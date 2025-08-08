require "test_helper"

class CheckSymbolsPricesJobTest < ActiveJob::TestCase
  test "process all suitable alerts" do
    ethusdt = alerts(:ethusdt)
    btcusdt = alerts(:btcusdt)

    ethusdt.update_columns(price_threshold: 3895, status: :active)
    btcusdt.update_columns(price_threshold: 116_652, status: :active)

    VCR.use_cassette("check_symbols_prices_job") do
      perform_enqueued_jobs do
        CheckSymbolsPricesJob.perform_later
      end
    end

    ethusdt.reload
    btcusdt.reload

    assert_equal "completed", ethusdt.status
    assert_equal "completed", btcusdt.status
  end

  test "process only active alerts" do
    ethusdt = alerts(:ethusdt)
    btcusdt = alerts(:btcusdt)

    ethusdt.update_columns(price_threshold: 3895, status: :pending)
    btcusdt.update_columns(price_threshold: 116_652, status: :active)

    VCR.use_cassette("check_symbols_prices_job") do
      perform_enqueued_jobs do
        CheckSymbolsPricesJob.perform_later
      end
    end

    ethusdt.reload
    btcusdt.reload

    assert_equal "pending", ethusdt.status
    assert_equal "completed", btcusdt.status
  end

  test "process only suitable alerts" do
    ethusdt = alerts(:ethusdt)
    btcusdt = alerts(:btcusdt)

    ethusdt.update_columns(price_threshold: 3895, direction: :down, status: :active)
    btcusdt.update_columns(price_threshold: 116_652, status: :active)

    VCR.use_cassette("check_symbols_prices_job") do
      perform_enqueued_jobs do
        CheckSymbolsPricesJob.perform_later
      end
    end

    ethusdt.reload
    btcusdt.reload

    assert_equal "active", ethusdt.status
    assert_equal "completed", btcusdt.status
  end
end
