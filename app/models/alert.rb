class Alert < ApplicationRecord
  enum :status, %w[ pending active completed ].index_by(&:itself), default: :pending
  enum :direction, %w[ up down ]

  validates :symbol, presence: true, inclusion: { in: %w[ ETHUSDT BTCUSDT ] }
  validates :threshold, presence: true, numericality: { greater_than: 0 }
  validates :direction, presence: true
  validates :email_address,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            allow_blank: true
  validates :webhook_url,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) },
            allow_blank: true

  after_commit :generate_price_threshold
  after_commit :send_notification

  private
    def generate_price_threshold
      GeneratePriceThresholdJob.perform_later(self) if price_threshold.blank?
    end

    def accepted_symbols
      %w[ ETHUSDT BTCUSDT ]
    end

    def send_notification
      if saved_change_to_status? && status == "completed"
        AlertDelivery.with(alert: self).triggered.deliver_now
      end
    end
end
