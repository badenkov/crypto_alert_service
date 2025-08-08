require "test_helper"

class GeneratePriceThresholdJobTest < ActiveJob::TestCase
  test "should calcuate price_threshold correctly with direction up" do
    alert = alerts(:ethusdt)
    alert.update!(price_threshold: nil)

    VCR.use_cassette("generate_price_threshold_job-up") do
      perform_enqueued_jobs do
        GeneratePriceThresholdJob.perform_later(alert)
      end
    end

    alert.reload

    assert_equal 3919.71, alert.price_threshold
  end

  test "should calcuate price_threshold correctly with direction down" do
    alert = alerts(:btcusdt)
    alert.update!(price_threshold: nil)

    VCR.use_cassette("generate_price_threshold_job-down") do
      perform_enqueued_jobs do
        GeneratePriceThresholdJob.perform_later(alert)
      end
    end

    alert.reload

    assert_equal 116899.0, alert.price_threshold
  end
end
