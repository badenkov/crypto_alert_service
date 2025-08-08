class Alert < ApplicationRecord
  enum :direction, %w[ up down ]

  validates :symbol, presence: true, inclusion: { in: %w[ ETHUSDT BTCUSDT ] }
  validates :threshold, presence: true, numericality: { greater_than: 0 }
  validates :direction, presence: true

  after_commit :generate_price_threshold

  private
    def generate_price_threshold
      GeneratePriceThresholdJob.perform_later(self) if price_threshold.blank?
    end

    def accepted_symbols
      %w[ ETHUSDT BTCUSDT ]
    end
end
