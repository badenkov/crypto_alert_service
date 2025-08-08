class Alert < ApplicationRecord
  enum :direction, %w[ up down ]

  # validates :symbol, pre

  after_commit :generate_price_threshold

  private
    def generate_price_threshold
      GeneratePriceThresholdJob.perform_later(self) if price_threshold.blank?
    end
end
